import 'package:flutter/material.dart';
import 'package:miruvor/core/models/bottle.dart';
import 'package:miruvor/core/models/purchase.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/store/miruvor_scope.dart';
import 'package:miruvor/features/shared/presentation/date_picker_field.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({required this.wine, this.initialPurchase, super.key});
  final Wine wine;
  final Purchase? initialPurchase;
  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  final _key = GlobalKey<FormState>();
  final _quantity = TextEditingController(text: '1');
  final _total = TextEditingController();
  final _shop = TextEditingController();
  final _volume = TextEditingController();
  final _note = TextEditingController();
  final _storage = TextEditingController();
  DateTime? _date;
  bool _consumed = false, _saving = false;
  @override
  void initState() {
    super.initState();
    final p = widget.initialPurchase;
    if (p != null) {
      _quantity.text = p.purchasedQuantity.toString();
      _total.text = p.totalPaidKrw?.toString() ?? '';
      _shop.text = p.shopName ?? '';
      _volume.text = p.volumeMl?.toString() ?? '';
      _note.text = p.note ?? '';
      _date = p.purchaseDate;
    }
  }

  @override
  void dispose() {
    for (final c in [_quantity, _total, _shop, _volume, _note, _storage]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Text(widget.initialPurchase == null ? '구매 추가' : '구매 수정')),
        body: Form(
            key: _key,
            child: ListView(padding: const EdgeInsets.all(16), children: [
              Text('${widget.wine.displayName} ${widget.wine.displayVintage}'),
              const SizedBox(height: 16),
              TextFormField(
                  controller: _quantity,
                  decoration: const InputDecoration(labelText: '구매 수량'),
                  keyboardType: TextInputType.number,
                  validator: (v) => _number(v, required: true, minimum: 1)),
              const SizedBox(height: 12),
              TextFormField(
                  controller: _total,
                  decoration: const InputDecoration(
                      labelText: '구매 총액',
                      helperText: '이 수량 전체의 결제액 · 모르면 비워 두세요'),
                  keyboardType: TextInputType.number,
                  validator: (v) => _number(v, minimum: 0)),
              const SizedBox(height: 12),
              DatePickerField(
                  label: '구매일',
                  value: _date,
                  onChanged: (v) => setState(() => _date = v)),
              const SizedBox(height: 12),
              TextFormField(
                  controller: _shop,
                  decoration: const InputDecoration(labelText: '구매처')),
              const SizedBox(height: 12),
              TextFormField(
                  controller: _volume,
                  decoration: const InputDecoration(labelText: '병 용량 (mL)'),
                  keyboardType: TextInputType.number,
                  validator: (v) => _number(v, minimum: 1)),
              const SizedBox(height: 12),
              TextFormField(
                  controller: _note,
                  decoration: const InputDecoration(labelText: '구매 메모'),
                  maxLines: 2),
              if (widget.initialPurchase == null) ...[
                const SizedBox(height: 12),
                TextFormField(
                    controller: _storage,
                    decoration: const InputDecoration(labelText: '보관 위치')),
                CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('마신 병으로 표시'),
                    value: _consumed,
                    onChanged: (v) => setState(() => _consumed = v ?? false)),
              ] else ...[
                const SizedBox(height: 12),
                const Text('수량 정정은 병을 추가하거나 삭제하지 않습니다. 용량 정정은 연결된 병에도 반영됩니다.'),
              ],
              const SizedBox(height: 20),
              FilledButton(
                  onPressed: _saving ? null : _save,
                  child: Text(_saving
                      ? '저장 중'
                      : widget.initialPurchase == null
                          ? '저장'
                          : '수정 저장')),
            ])),
      );

  Future<void> _save() async {
    if (!_key.currentState!.validate()) return;
    setState(() => _saving = true);
    final store = MiruvorScope.of(context);
    try {
      final original = widget.initialPurchase;
      if (original == null) {
        await store.addPurchase(
            wineId: widget.wine.id,
            purchasedQuantity: int.parse(_quantity.text),
            totalPaidKrw: int.tryParse(_total.text),
            purchaseDate: _date,
            shopName: _text(_shop),
            volumeMl: int.tryParse(_volume.text),
            note: _text(_note),
            storageLocation: _text(_storage),
            status: _consumed ? BottleStatus.consumed : BottleStatus.inStock);
      } else {
        await store.savePurchase(Purchase(
            id: original.id,
            wineId: original.wineId,
            purchasedQuantity: int.parse(_quantity.text),
            totalPaidKrw: int.tryParse(_total.text),
            purchaseDate: _date,
            shopName: _text(_shop),
            volumeMl: int.tryParse(_volume.text),
            note: _text(_note)));
      }
      if (mounted) Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;
      setState(() => _saving = false);
      final message =
          error is ArgumentError ? error.message.toString() : '구매를 저장하지 못했습니다.';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  String? _text(TextEditingController c) =>
      c.text.trim().isEmpty ? null : c.text.trim();
  String? _number(String? value,
      {bool required = false, required int minimum}) {
    if ((value?.trim().isEmpty ?? true) && !required) return null;
    final number = int.tryParse(value?.trim() ?? '');
    return number == null || number < minimum
        ? '$minimum 이상의 정수를 입력하세요.'
        : null;
  }
}
