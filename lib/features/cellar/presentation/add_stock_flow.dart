import 'package:flutter/material.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/models/wine_filter.dart';
import 'package:miruvor/core/store/miruvor_scope.dart';
import 'package:miruvor/features/cellar/presentation/add_wine_page.dart';
import 'package:miruvor/features/cellar/presentation/bottle_page.dart';
import 'package:miruvor/features/cellar/presentation/purchase_page.dart';

/// Choose an existing identity before adding stock; new labels remain explicit.
Future<void> addCellarStock(BuildContext context) async {
  final store = MiruvorScope.of(context);
  final selection = await Navigator.of(context).push<_StockSelection>(
      MaterialPageRoute(builder: (_) => const _SelectStockWinePage()));
  if (selection == null || !context.mounted) return;

  var wine = selection.wine;
  if (wine == null) {
    String? createdId;
    await Navigator.of(context).push<void>(MaterialPageRoute(
        builder: (_) => AddWinePage(onCreated: (id) => createdId = id)));
    if (createdId == null || !context.mounted) return;
    wine = await store.findWine(createdId!);
  }
  if (wine == null || !context.mounted) return;
  final selectedWine = wine;
  await Navigator.of(context).push<void>(MaterialPageRoute(
      builder: (_) => selection.isGift
          ? BottlePage(wine: selectedWine)
          : PurchasePage(wine: selectedWine)));
}

class _StockSelection {
  const _StockSelection({this.wine, required this.isGift});
  final Wine? wine;
  final bool isGift;
}

class _SelectStockWinePage extends StatefulWidget {
  const _SelectStockWinePage();

  @override
  State<_SelectStockWinePage> createState() => _SelectStockWinePageState();
}

class _SelectStockWinePageState extends State<_SelectStockWinePage> {
  String _query = '';
  bool _isGift = false;

  void _select([Wine? wine]) =>
      Navigator.of(context).pop(_StockSelection(wine: wine, isGift: _isGift));

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('보유 와인 추가')),
        body: StreamBuilder<List<Wine>>(
            stream: MiruvorScope.of(context).watchWines(),
            builder: (context, snapshot) {
              final filter = WineFilter(query: _query);
              final wines = (snapshot.data ?? const <Wine>[])
                  .where((wine) => filter.matches(wine, null))
                  .toList();
              return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: 1 + (wines.isEmpty ? 1 : wines.length),
                  itemBuilder: (context, index) {
                    if (index == 0) return _header();
                    if (snapshot.hasError) {
                      return const Text('와인 목록을 불러오지 못했습니다.');
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (wines.isEmpty) {
                      return const Text('일치하는 와인이 없습니다. 새 와인을 등록해 주세요.');
                    }
                    final wine = wines[index - 1];
                    return ListTile(
                        title:
                            Text('${wine.displayName} ${wine.displayVintage}'),
                        subtitle: Text(wine.producer ?? '생산자 미상'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => _select(wine));
                  });
            }),
      );

  Widget _header() => Column(children: [
        const Text('기록한 와인이면 선택하고, 처음이면 새로 등록하세요.'),
        SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('선물받은 병 추가'),
            subtitle: const Text('구매 금액 없이 병과 보관 위치만 기록'),
            value: _isGift,
            onChanged: (value) => setState(() => _isGift = value)),
        TextFormField(
            initialValue: _query,
            decoration: const InputDecoration(
                labelText: '기존 와인 검색', prefixIcon: Icon(Icons.search)),
            onChanged: (value) => setState(() => _query = value)),
        const SizedBox(height: 12),
        OutlinedButton.icon(
            onPressed: () => _select(),
            icon: const Icon(Icons.add),
            label: const Text('새 와인 등록 후 추가')),
        const SizedBox(height: 12),
      ]);
}
