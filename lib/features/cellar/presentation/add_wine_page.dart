import 'package:flutter/material.dart';
import 'package:miruvor/core/models/wine_type.dart';
import 'package:miruvor/core/store/miruvor_scope.dart';

class AddWinePage extends StatefulWidget {
  const AddWinePage({super.key});

  @override
  State<AddWinePage> createState() => _AddWinePageState();
}

class _AddWinePageState extends State<AddWinePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _producerController = TextEditingController();
  final _countryController = TextEditingController();
  final _regionController = TextEditingController();
  final _vintageController = TextEditingController();
  final _grapeVarietiesController = TextEditingController();
  final _shopNameController = TextEditingController();
  final _storageLocationController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _referencePriceController = TextEditingController();

  WineType _type = WineType.red;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _producerController.dispose();
    _countryController.dispose();
    _regionController.dispose();
    _vintageController.dispose();
    _grapeVarietiesController.dispose();
    _shopNameController.dispose();
    _storageLocationController.dispose();
    _purchasePriceController.dispose();
    _referencePriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Wine')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(Icons.add_a_photo_outlined, size: 36),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: '이름'),
              textInputAction: TextInputAction.next,
              validator: _required,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _producerController,
              decoration: const InputDecoration(labelText: '생산자'),
              textInputAction: TextInputAction.next,
              validator: _required,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _countryController,
              decoration: const InputDecoration(labelText: '국가'),
              textInputAction: TextInputAction.next,
              validator: _required,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _regionController,
              decoration: const InputDecoration(labelText: '지역'),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<WineType>(
              initialValue: _type,
              decoration: const InputDecoration(labelText: '종류'),
              items: WineType.values.map((type) {
                return DropdownMenuItem(value: type, child: Text(type.label));
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _type = value);
                }
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _vintageController,
              decoration: const InputDecoration(labelText: '빈티지'),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: _optionalInt,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _grapeVarietiesController,
              decoration: const InputDecoration(labelText: '포도 품종'),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _shopNameController,
              decoration: const InputDecoration(labelText: '구매처'),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _storageLocationController,
              decoration: const InputDecoration(labelText: '보관 위치'),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _purchasePriceController,
              decoration: const InputDecoration(labelText: '구매 가격'),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: _requiredInt,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _referencePriceController,
              decoration: const InputDecoration(labelText: '수동 기준가'),
              keyboardType: TextInputType.number,
              validator: _optionalInt,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              icon: _isSaving
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save_outlined),
              label: const Text('저장'),
              onPressed: _isSaving ? null : _save,
            ),
          ],
        ),
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
      await store.addWinePurchase(
        name: _nameController.text.trim(),
        producer: _producerController.text.trim(),
        country: _countryController.text.trim(),
        region: _nullableText(_regionController),
        vintage: _nullableInt(_vintageController),
        type: _type,
        grapeVarieties: _grapeVarietiesController.text
            .split(',')
            .map((value) => value.trim())
            .where((value) => value.isNotEmpty)
            .toList(),
        shopName: _nullableText(_shopNameController),
        storageLocation: _nullableText(_storageLocationController),
        purchaseDate: DateTime.now(),
        purchasePrice: _requiredParsedInt(_purchasePriceController),
        referencePrice: _nullableInt(_referencePriceController),
      );
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

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '필수 입력값입니다.';
    }
    return null;
  }

  String? _requiredInt(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '필수 입력값입니다.';
    }
    if (int.tryParse(value.trim()) == null) {
      return '숫자로 입력해 주세요.';
    }
    return null;
  }

  String? _optionalInt(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    if (int.tryParse(value.trim()) == null) {
      return '숫자로 입력해 주세요.';
    }
    return null;
  }

  String? _nullableText(TextEditingController controller) {
    final value = controller.text.trim();
    return value.isEmpty ? null : value;
  }

  int? _nullableInt(TextEditingController controller) {
    final value = controller.text.trim();
    return value.isEmpty ? null : int.parse(value);
  }

  int _requiredParsedInt(TextEditingController controller) {
    return int.parse(controller.text.trim());
  }
}
