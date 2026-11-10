import 'package:flutter/material.dart';
import 'package:miruvor/core/models/bottle.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/store/miruvor_scope.dart';
import 'package:miruvor/features/shared/presentation/date_picker_field.dart';
import 'package:miruvor/features/shared/presentation/photo_picker_field.dart';

class BottlePage extends StatefulWidget {
  const BottlePage({required this.wine, this.initialBottle, super.key});
  final Wine wine;
  final Bottle? initialBottle;
  @override
  State<BottlePage> createState() => _BottlePageState();
}

class _BottlePageState extends State<BottlePage> {
  final _key = GlobalKey<FormState>();
  final _volume = TextEditingController();
  final _storage = TextEditingController();
  AcquisitionKind _kind = AcquisitionKind.gift;
  BottleStatus _status = BottleStatus.inStock;
  DateTime? _acquiredAt, _statusChangedAt;
  String? _photo;
  bool _linked = false, _saving = false;
  @override
  void initState() {
    super.initState();
    final b = widget.initialBottle;
    if (b != null) {
      _kind = b.acquisitionKind;
      _status = b.status;
      _acquiredAt = b.acquiredAt;
      _statusChangedAt = b.statusChangedAt;
      _photo = b.imagePath;
      _linked = b.purchaseId != null;
      _volume.text = b.volumeMl?.toString() ?? '';
      _storage.text = b.storageLocation ?? '';
    }
  }

  @override
  void dispose() {
    _volume.dispose();
    _storage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title:
                Text(widget.initialBottle == null ? '구매 없이 병 추가' : '병 정보 수정')),
        body: Form(
            key: _key,
            child: ListView(padding: const EdgeInsets.all(16), children: [
              Text(widget.wine.displayName),
              const SizedBox(height: 12),
              PhotoPickerField(
                  imagePath: _photo,
                  onImageSelected: (v) => setState(() => _photo = v)),
              const SizedBox(height: 12),
              if (widget.initialBottle?.purchaseId != null)
                CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('기존 구매 연결 유지'),
                    subtitle: const Text('해제해도 구매 기록과 시음 노트는 유지됩니다.'),
                    value: _linked,
                    onChanged: (v) => setState(() {
                          _linked = v ?? false;
                          if (_linked) {
                            _kind = AcquisitionKind.purchase;
                            _volume.text =
                                widget.initialBottle!.volumeMl?.toString() ??
                                    '';
                          }
                        })),
              DropdownButtonFormField<AcquisitionKind>(
                  key: ValueKey(_linked),
                  initialValue: _kind,
                  decoration: const InputDecoration(labelText: '취득 종류'),
                  items: const [
                    DropdownMenuItem(
                        value: AcquisitionKind.gift, child: Text('선물받음')),
                    DropdownMenuItem(
                        value: AcquisitionKind.purchase, child: Text('구매')),
                    DropdownMenuItem(
                        value: AcquisitionKind.other, child: Text('기타')),
                    DropdownMenuItem(
                        value: AcquisitionKind.unknown, child: Text('미상')),
                  ],
                  onChanged:
                      _linked ? null : (v) => setState(() => _kind = v!)),
              const SizedBox(height: 12),
              DatePickerField(
                  label: '취득일',
                  value: _acquiredAt,
                  onChanged: (v) => setState(() => _acquiredAt = v)),
              const SizedBox(height: 12),
              TextFormField(
                  controller: _volume,
                  readOnly: _linked,
                  decoration: InputDecoration(
                      labelText: '병 용량 (mL)',
                      helperText:
                          _linked ? '연결된 구매 기록에서 용량을 정정할 수 있습니다.' : null),
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return null;
                    return (int.tryParse(v.trim()) ?? 0) <= 0
                        ? '양의 정수를 입력하세요.'
                        : null;
                  }),
              const SizedBox(height: 12),
              TextFormField(
                  controller: _storage,
                  decoration: const InputDecoration(labelText: '보관 위치')),
              const SizedBox(height: 12),
              DropdownButtonFormField<BottleStatus>(
                  initialValue: _status,
                  decoration: const InputDecoration(labelText: '병 상태'),
                  items: BottleStatus.values
                      .map((s) =>
                          DropdownMenuItem(value: s, child: Text(s.label)))
                      .toList(),
                  onChanged: (v) => setState(() {
                        if (v != _status) _statusChangedAt = null;
                        _status = v!;
                      })),
              const SizedBox(height: 12),
              DatePickerField(
                  label: '상태 변경일',
                  value: _statusChangedAt,
                  onChanged: (v) => setState(() => _statusChangedAt = v)),
              const SizedBox(height: 20),
              FilledButton(
                  onPressed: _saving ? null : _save,
                  child: Text(_saving
                      ? '저장 중'
                      : widget.initialBottle == null
                          ? '저장'
                          : '수정 저장')),
            ])),
      );

  Future<void> _save() async {
    if (!_key.currentState!.validate()) return;
    setState(() => _saving = true);
    final store = MiruvorScope.of(context);
    String? imported;
    try {
      final previous = widget.initialBottle;
      var photo = _photo;
      if (photo != null && photo != previous?.imagePath) {
        photo = imported = await store.importImage(photo, prefix: 'bottle');
      }
      if (previous == null) {
        await store.addBottle(
            wineId: widget.wine.id,
            acquisitionKind: _kind,
            acquiredAt: _acquiredAt,
            volumeMl: int.tryParse(_volume.text),
            storageLocation: _storage.text,
            imagePath: photo,
            status: _status,
            statusChangedAt: _statusChangedAt);
      } else {
        await store.saveBottle(Bottle(
            id: previous.id,
            wineId: previous.wineId,
            purchaseId: _linked ? previous.purchaseId : null,
            acquisitionKind: _kind,
            acquiredAt: _acquiredAt,
            volumeMl: int.tryParse(_volume.text),
            storageLocation:
                _storage.text.trim().isEmpty ? null : _storage.text.trim(),
            imagePath: photo,
            status: _status,
            statusChangedAt: _statusChangedAt));
      }
      if (mounted) Navigator.of(context).pop(true);
    } catch (error) {
      await store.discardImage(imported);
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error is ArgumentError
              ? error.message.toString()
              : '병 정보를 저장하지 못했습니다.')));
    }
  }
}
