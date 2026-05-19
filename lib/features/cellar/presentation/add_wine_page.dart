import 'package:flutter/material.dart';
import 'package:miruvor/core/media/local_image_store.dart';
import 'package:miruvor/core/models/bottle.dart';
import 'package:miruvor/core/models/price_observation.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/models/wine_type.dart';
import 'package:miruvor/core/store/miruvor_scope.dart';
import 'package:miruvor/features/shared/presentation/photo_picker_field.dart';

class AddWinePage extends StatefulWidget {
  const AddWinePage({
    this.initialWine,
    this.initialBottle,
    this.initialReferencePrice,
    super.key,
  });

  final Wine? initialWine;
  final Bottle? initialBottle;
  final PriceObservation? initialReferencePrice;

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
  final _imageStore = LocalImageStore();

  WineType _type = WineType.red;
  String? _selectedImagePath;
  bool _isConsumed = false;
  bool _isSaving = false;
  bool get _isEditing =>
      widget.initialWine != null && widget.initialBottle != null;

  @override
  void initState() {
    super.initState();

    final wine = widget.initialWine;
    final bottle = widget.initialBottle;
    final referencePrice = widget.initialReferencePrice;

    if (wine != null && bottle != null) {
      _nameController.text = wine.name;
      _producerController.text = wine.producer;
      _countryController.text = wine.country;
      _regionController.text = wine.region ?? '';
      _vintageController.text = wine.vintage?.toString() ?? '';
      _grapeVarietiesController.text = wine.grapeVarieties.join(', ');
      _shopNameController.text = bottle.shopName ?? '';
      _storageLocationController.text = bottle.storageLocation ?? '';
      _purchasePriceController.text = bottle.purchasePrice.toString();
      _referencePriceController.text = referencePrice?.price.toString() ?? '';
      _type = wine.type;
      _selectedImagePath = bottle.imagePath;
      _isConsumed = bottle.isConsumed;
    }
  }

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
      appBar: AppBar(title: Text(_isEditing ? 'Edit Wine' : 'Add Wine')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            PhotoPickerField(
              imagePath: _selectedImagePath,
              onImageSelected: (path) {
                setState(() => _selectedImagePath = path);
              },
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
            const SizedBox(height: 12),
            CheckboxListTile(
              value: _isConsumed,
              contentPadding: EdgeInsets.zero,
              title: const Text('마신 병으로 표시'),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                setState(() => _isConsumed = value ?? false);
              },
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
      final referencePrice = _nullableInt(_referencePriceController);
      final grapeVarieties = _grapeVarietiesController.text
          .split(',')
          .map((value) => value.trim())
          .where((value) => value.isNotEmpty)
          .toList();

      if (_isEditing) {
        await store.updateWinePurchase(
          wineId: widget.initialWine!.id,
          bottleId: widget.initialBottle!.id,
          purchaseDate: widget.initialBottle!.purchaseDate,
          name: _nameController.text.trim(),
          producer: _producerController.text.trim(),
          country: _countryController.text.trim(),
          region: _nullableText(_regionController),
          vintage: _nullableInt(_vintageController),
          type: _type,
          grapeVarieties: grapeVarieties,
          shopName: _nullableText(_shopNameController),
          storageLocation: _nullableText(_storageLocationController),
          purchasePrice: _requiredParsedInt(_purchasePriceController),
          referencePrice: referencePrice,
          imagePath: storedImagePath,
          isConsumed: _isConsumed,
        );
      } else {
        await store.addWinePurchase(
          name: _nameController.text.trim(),
          producer: _producerController.text.trim(),
          country: _countryController.text.trim(),
          region: _nullableText(_regionController),
          vintage: _nullableInt(_vintageController),
          type: _type,
          grapeVarieties: grapeVarieties,
          shopName: _nullableText(_shopNameController),
          storageLocation: _nullableText(_storageLocationController),
          purchaseDate: DateTime.now(),
          purchasePrice: _requiredParsedInt(_purchasePriceController),
          referencePrice: referencePrice,
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

    Navigator.of(context).pop(true);
  }

  Future<String?> _storedImagePath() async {
    if (_selectedImagePath == null) {
      return null;
    }
    if (_selectedImagePath == widget.initialBottle?.imagePath) {
      return _selectedImagePath;
    }

    return _imageStore.copyIntoAppStorage(
      _selectedImagePath!,
      prefix: 'bottle',
    );
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
