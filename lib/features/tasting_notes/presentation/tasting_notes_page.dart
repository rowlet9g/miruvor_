import 'dart:io';

import 'package:flutter/material.dart';
import 'package:miruvor/core/media/local_image_store.dart';
import 'package:miruvor/core/models/tasting_note.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/store/miruvor_scope.dart';
import 'package:miruvor/core/utils/formatters.dart';
import 'package:miruvor/features/shared/presentation/photo_picker_field.dart';

class TastingNotesPage extends StatelessWidget {
  const TastingNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = MiruvorScope.of(context);

    return StreamBuilder<List<TastingNote>>(
      stream: store.watchTastingNotes(),
      builder: (context, snapshot) {
        final notes = snapshot.data ?? const <TastingNote>[];

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          itemCount: notes.length + 1,
          separatorBuilder: (_, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            if (index == 0) {
              return FilledButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('테이스팅 노트 추가'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const _AddTastingNotePage(),
                    ),
                  );
                },
              );
            }

            final note = notes[index - 1];
            return _TastingNoteListCard(note: note);
          },
        );
      },
    );
  }
}

class _TastingNoteListCard extends StatelessWidget {
  const _TastingNoteListCard({required this.note});

  final TastingNote note;

  @override
  Widget build(BuildContext context) {
    final store = MiruvorScope.of(context);

    return FutureBuilder<Wine?>(
      future: store.findWine(note.wineId),
      builder: (context, snapshot) {
        final wine = snapshot.data;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        wine == null
                            ? '알 수 없는 와인'
                            : '${wine.name} ${wine.displayVintage}',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    ),
                    PopupMenuButton<_TastingNoteAction>(
                      tooltip: '노트 작업',
                      onSelected: (action) {
                        switch (action) {
                          case _TastingNoteAction.edit:
                            _editNote(context);
                          case _TastingNoteAction.delete:
                            _deleteNote(context);
                        }
                      },
                      itemBuilder: (context) {
                        return const [
                          PopupMenuItem(
                            value: _TastingNoteAction.edit,
                            child: Text('수정'),
                          ),
                          PopupMenuItem(
                            value: _TastingNoteAction.delete,
                            child: Text('삭제'),
                          ),
                        ];
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '${formatDate(note.tastedAt)} · ${note.rating.toStringAsFixed(1)} / 5.0',
                ),
                if (note.imagePath != null) ...[
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(note.imagePath!),
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                if (note.aroma != null) Text('Aroma: ${note.aroma}'),
                if (note.palate != null) ...[
                  const SizedBox(height: 6),
                  Text('Palate: ${note.palate}'),
                ],
                if (note.pairing != null) ...[
                  const SizedBox(height: 6),
                  Text('Pairing: ${note.pairing}'),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _editNote(BuildContext context) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (context) => _AddTastingNotePage(initialNote: note),
      ),
    );
  }

  Future<void> _deleteNote(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('테이스팅 노트 삭제'),
          content: const Text('이 노트를 삭제합니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('취소'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('삭제'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    await MiruvorScope.of(context).deleteTastingNote(note.id);
  }
}

enum _TastingNoteAction { edit, delete }

class _AddTastingNotePage extends StatefulWidget {
  const _AddTastingNotePage({this.initialNote});

  final TastingNote? initialNote;

  @override
  State<_AddTastingNotePage> createState() => _AddTastingNotePageState();
}

class _AddTastingNotePageState extends State<_AddTastingNotePage> {
  final _formKey = GlobalKey<FormState>();
  final _pairingController = TextEditingController();
  final _aromaController = TextEditingController();
  final _palateController = TextEditingController();
  final _memoController = TextEditingController();
  final _ratingController = TextEditingController(text: '4.0');
  final _imageStore = LocalImageStore();

  String? _wineId;
  String? _selectedImagePath;
  bool _isSaving = false;
  bool get _isEditing => widget.initialNote != null;

  @override
  void initState() {
    super.initState();

    final note = widget.initialNote;
    if (note != null) {
      _wineId = note.wineId;
      _selectedImagePath = note.imagePath;
      _ratingController.text = note.rating.toStringAsFixed(1);
      _pairingController.text = note.pairing ?? '';
      _aromaController.text = note.aroma ?? '';
      _palateController.text = note.palate ?? '';
      _memoController.text = note.memo ?? '';
    }
  }

  @override
  void dispose() {
    _pairingController.dispose();
    _aromaController.dispose();
    _palateController.dispose();
    _memoController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = MiruvorScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Tasting Note' : 'Add Tasting Note'),
      ),
      body: StreamBuilder<List<Wine>>(
        stream: store.watchWines(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final wines = snapshot.data ?? const <Wine>[];
          final selectedWineId =
              wines.any((wine) => wine.id == _wineId) ? _wineId : null;

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              children: [
                PhotoPickerField(
                  imagePath: _selectedImagePath,
                  height: 140,
                  onImageSelected: (path) {
                    setState(() => _selectedImagePath = path);
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedWineId,
                  decoration: const InputDecoration(labelText: '와인'),
                  items: wines.map((wine) {
                    return DropdownMenuItem(
                      value: wine.id,
                      child: Text('${wine.name} ${wine.displayVintage}'),
                    );
                  }).toList(),
                  onChanged: _isEditing
                      ? null
                      : (value) => setState(() => _wineId = value),
                  validator: (value) {
                    if (value == null) {
                      return '와인을 선택해 주세요.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _ratingController,
                  decoration: const InputDecoration(labelText: '평점'),
                  keyboardType: TextInputType.number,
                  validator: _ratingValidator,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _pairingController,
                  decoration: const InputDecoration(labelText: '페어링 음식'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _aromaController,
                  decoration: const InputDecoration(labelText: '향'),
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _palateController,
                  decoration: const InputDecoration(labelText: '맛'),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _memoController,
                  decoration: const InputDecoration(labelText: '메모'),
                  maxLines: 4,
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  icon: _isSaving
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_outlined),
                  label: Text(_isEditing ? '수정 저장' : '저장'),
                  onPressed: _isSaving ? null : _save,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSaving = true);
    final store = MiruvorScope.of(context);

    try {
      final storedImagePath = await _storedImagePath();
      if (_isEditing) {
        await store.updateTastingNote(
          id: widget.initialNote!.id,
          wineId: widget.initialNote!.wineId,
          bottleId: widget.initialNote!.bottleId,
          tastedAt: widget.initialNote!.tastedAt,
          rating: double.parse(_ratingController.text.trim()),
          pairing: _nullableText(_pairingController),
          aroma: _nullableText(_aromaController),
          palate: _nullableText(_palateController),
          memo: _nullableText(_memoController),
          imagePath: storedImagePath,
        );
      } else {
        await store.addTastingNote(
          wineId: _wineId!,
          tastedAt: DateTime.now(),
          rating: double.parse(_ratingController.text.trim()),
          pairing: _nullableText(_pairingController),
          aroma: _nullableText(_aromaController),
          palate: _nullableText(_palateController),
          memo: _nullableText(_memoController),
          imagePath: storedImagePath,
        );
      }
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('저장에 실패했습니다.')),
      );
      return;
    }

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop();
  }

  Future<String?> _storedImagePath() async {
    if (_selectedImagePath == null) {
      return null;
    }
    if (_selectedImagePath == widget.initialNote?.imagePath) {
      return _selectedImagePath;
    }

    return _imageStore.copyIntoAppStorage(
      _selectedImagePath!,
      prefix: 'tasting-note',
    );
  }

  String? _ratingValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '필수 입력값입니다.';
    }
    final rating = double.tryParse(value.trim());
    if (rating == null || rating < 0 || rating > 5) {
      return '0부터 5 사이 숫자로 입력해 주세요.';
    }
    return null;
  }

  String? _nullableText(TextEditingController controller) {
    final value = controller.text.trim();
    return value.isEmpty ? null : value;
  }
}
