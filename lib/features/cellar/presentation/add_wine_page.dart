import 'package:flutter/material.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/models/wine_type.dart';
import 'package:miruvor/core/store/miruvor_scope.dart';
import 'package:miruvor/features/shared/presentation/photo_picker_field.dart';

class AddWinePage extends StatefulWidget {
  const AddWinePage({this.initialWine, super.key});
  final Wine? initialWine;
  @override
  State<AddWinePage> createState() => _AddWinePageState();
}

class _AddWinePageState extends State<AddWinePage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _producer = TextEditingController();
  final _country = TextEditingController();
  final _region = TextEditingController();
  final _vintage = TextEditingController();
  final _grapes = TextEditingController();
  WineType? _type;
  VintageKind _vintageKind = VintageKind.unknown;
  String? _photo;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final wine = widget.initialWine;
    if (wine != null) {
      _name.text = wine.name ?? '';
      _producer.text = wine.producer ?? '';
      _country.text = wine.country ?? '';
      _region.text = wine.region ?? '';
      _vintage.text = wine.vintage?.toString() ?? '';
      _grapes.text = wine.grapeVarieties.join(', ');
      _type = wine.type;
      _vintageKind = wine.vintageKind;
      _photo = wine.imagePath;
    }
  }

  @override
  void dispose() {
    for (final c in [_name, _producer, _country, _region, _vintage, _grapes]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Text(widget.initialWine == null ? '와인 등록' : '와인 정보 수정')),
        body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text('이름 또는 사진으로 등록할 수 있습니다. 구매와 병은 상세 화면에서 추가하세요.'),
                const SizedBox(height: 12),
                PhotoPickerField(
                    imagePath: _photo,
                    onImageSelected: (path) => setState(() => _photo = path)),
                const SizedBox(height: 12),
                TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(labelText: '이름'),
                    validator: (v) =>
                        (v?.trim().isEmpty ?? true) && _photo == null
                            ? '이름 또는 사진이 필요합니다.'
                            : null),
                const SizedBox(height: 12),
                TextFormField(
                    controller: _producer,
                    decoration: const InputDecoration(labelText: '생산자')),
                const SizedBox(height: 12),
                TextFormField(
                    controller: _country,
                    decoration: const InputDecoration(labelText: '국가')),
                const SizedBox(height: 12),
                TextFormField(
                    controller: _region,
                    decoration: const InputDecoration(labelText: '지역')),
                const SizedBox(height: 12),
                DropdownButtonFormField<WineType>(
                    initialValue: _type,
                    decoration: const InputDecoration(labelText: '종류'),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('미상')),
                      ...WineType.values.map((t) =>
                          DropdownMenuItem(value: t, child: Text(t.label)))
                    ],
                    onChanged: (v) => setState(() => _type = v)),
                const SizedBox(height: 12),
                DropdownButtonFormField<VintageKind>(
                    initialValue: _vintageKind,
                    decoration: const InputDecoration(labelText: '빈티지 구분'),
                    items: const [
                      DropdownMenuItem(
                          value: VintageKind.unknown, child: Text('빈티지 미상')),
                      DropdownMenuItem(
                          value: VintageKind.year, child: Text('연도')),
                      DropdownMenuItem(
                          value: VintageKind.nonVintage, child: Text('NV')),
                    ],
                    onChanged: (v) => setState(() => _vintageKind = v!)),
                if (_vintageKind == VintageKind.year) ...[
                  const SizedBox(height: 12),
                  TextFormField(
                      controller: _vintage,
                      decoration: const InputDecoration(labelText: '빈티지'),
                      keyboardType: TextInputType.number,
                      validator: (v) => int.tryParse(v ?? '') == null
                          ? '연도를 숫자로 입력하세요.'
                          : null),
                ],
                const SizedBox(height: 12),
                TextFormField(
                    controller: _grapes,
                    decoration: const InputDecoration(labelText: '포도 품종')),
                const SizedBox(height: 20),
                FilledButton(
                    onPressed: _saving ? null : _save,
                    child: Text(_saving
                        ? '저장 중'
                        : widget.initialWine == null
                            ? '저장'
                            : '수정 저장')),
              ],
            )),
      );

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final store = MiruvorScope.of(context);
    String? imported;
    try {
      final original = widget.initialWine;
      var photo = _photo;
      if (photo != null && photo != original?.imagePath) {
        photo = imported = await store.importImage(photo, prefix: 'wine');
      }
      final grapes = _grapes.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
      final vintage =
          _vintageKind == VintageKind.year ? int.parse(_vintage.text) : null;
      if (original == null) {
        await store.createWine(
            name: _text(_name),
            producer: _text(_producer),
            country: _text(_country),
            region: _text(_region),
            vintage: vintage,
            vintageKind: _vintageKind,
            type: _type,
            grapeVarieties: grapes,
            imagePath: photo);
      } else {
        await store.saveWine(Wine(
            id: original.id,
            name: _text(_name),
            producer: _text(_producer),
            country: _text(_country),
            region: _text(_region),
            vintage: vintage,
            vintageKind: _vintageKind,
            type: _type,
            grapeVarieties: grapes,
            imagePath: photo,
            isArchived: original.isArchived,
            isWishlisted: original.isWishlisted));
      }
      if (mounted) Navigator.of(context).pop(true);
    } catch (error) {
      await store.discardImage(imported);
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('저장하지 못했습니다. 입력 내용을 확인해 주세요.')));
    }
  }

  String? _text(TextEditingController c) =>
      c.text.trim().isEmpty ? null : c.text.trim();
}
