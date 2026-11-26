import 'dart:io';

import 'package:flutter/material.dart';
import 'package:miruvor/core/database/app_database.dart';
import 'package:miruvor/core/models/bottle.dart';
import 'package:miruvor/core/models/wine_filter.dart';
import 'package:miruvor/core/store/miruvor_scope.dart';
import 'package:miruvor/core/utils/formatters.dart';
import 'package:miruvor/features/cellar/presentation/add_stock_flow.dart';
import 'package:miruvor/features/cellar/presentation/bottle_page.dart';
import 'package:miruvor/features/cellar/presentation/cellar_page.dart';
import 'package:miruvor/features/cellar/presentation/purchase_page.dart';
import 'package:miruvor/features/cellar/presentation/wine_detail_page.dart';

class CellarInventoryPage extends StatefulWidget {
  const CellarInventoryPage({super.key});

  @override
  State<CellarInventoryPage> createState() => _CellarInventoryPageState();
}

class _CellarInventoryPageState extends State<CellarInventoryPage> {
  final _search = TextEditingController();
  String? _location;
  bool _purchasedOnly = false;

  bool get _isFiltered =>
      _search.text.trim().isNotEmpty || _location != null || _purchasedOnly;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _reset() => setState(() {
        _search.clear();
        _location = null;
        _purchasedOnly = false;
      });

  @override
  Widget build(BuildContext context) => StreamBuilder<List<WineEntry>>(
        stream: MiruvorScope.of(context).watchCatalog(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('보유 와인을 불러오지 못했습니다.'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final entries = snapshot.data!;
          final locations = <String>{
            for (final entry in entries)
              for (final bottle in entry.bottles.where((b) => b.isInStock))
                _storage(bottle),
            // Keep a selected empty location available after its last bottle leaves.
            if (_location != null) _location!,
          }.toList()
            ..sort();
          final query = _search.text.trim().toLowerCase();
          final wineFilter = WineFilter(query: query);
          final groups = <_StockGroup>[];
          for (final entry in entries) {
            final wineMatches = wineFilter.matches(entry.wine, null);
            final bottles = entry.bottles
                .where((bottle) =>
                    bottle.isInStock &&
                    (!_purchasedOnly ||
                        bottle.acquisitionKind == AcquisitionKind.purchase) &&
                    (_location == null || _storage(bottle) == _location) &&
                    (wineMatches ||
                        _storage(bottle).toLowerCase().contains(query)))
                .toList();
            if (bottles.isNotEmpty) groups.add(_StockGroup(entry, bottles));
          }
          groups.sort((a, b) =>
              a.entry.wine.displayName.compareTo(b.entry.wine.displayName));
          final count =
              groups.fold(0, (total, group) => total + group.bottles.length);
          final cost =
              groups.fold(0.0, (total, group) => total + group.knownCost);
          final unknown =
              groups.fold(0, (total, group) => total + group.unknownCost);

          return ListView(padding: const EdgeInsets.all(16), children: [
            const Text('집에 남아 있는 와인을 한눈에 확인하고 병별로 관리하세요.'),
            const SizedBox(height: 12),
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${_isFiltered ? '표시 중' : '보유 중'} $count병 · ${groups.length}종',
                              key: const ValueKey('cellar-stock-summary'),
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 8),
                          Text('보유 병 구매 원가 ${formatKrw(cost)}',
                              key: const ValueKey('cellar-stock-cost')),
                          if (unknown > 0) Text('가격 미상 $unknown병 제외'),
                        ]))),
            const SizedBox(height: 12),
            Wrap(spacing: 8, runSpacing: 8, children: [
              FilledButton.icon(
                  onPressed: () => addCellarStock(context),
                  icon: const Icon(Icons.add),
                  label: const Text('보유 와인 추가')),
              TextButton(
                  onPressed: () => Navigator.of(context).push<void>(
                      MaterialPageRoute(
                          builder: (_) => Scaffold(
                              appBar: AppBar(title: const Text('전체 와인 기록')),
                              body: const CellarPage()))),
                  child: const Text('전체 와인 기록')),
            ]),
            const SizedBox(height: 16),
            TextFormField(
                controller: _search,
                decoration: const InputDecoration(
                    labelText: '와인·생산자·보관 위치 검색',
                    prefixIcon: Icon(Icons.search)),
                onChanged: (_) => setState(() {})),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
                key: ValueKey(_location),
                initialValue: _location,
                isExpanded: true,
                decoration: const InputDecoration(labelText: '보관 위치 필터'),
                items: [
                  const DropdownMenuItem(value: null, child: Text('모든 보관 위치')),
                  for (final location in locations)
                    DropdownMenuItem(value: location, child: Text(location)),
                ],
                onChanged: (value) => setState(() => _location = value)),
            SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('구매한 병만 보기'),
                subtitle: const Text('끄면 선물받은 병도 함께 표시'),
                value: _purchasedOnly,
                onChanged: (value) => setState(() => _purchasedOnly = value)),
            if (_isFiltered)
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: _reset, child: const Text('조건 초기화'))),
            const SizedBox(height: 8),
            if (groups.isEmpty)
              Card(
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(_isFiltered
                          ? '조건에 맞는 보유 와인이 없습니다.'
                          : '아직 보유 중인 와인이 없습니다.\n구매한 와인이나 선물받은 병을 추가해 보세요.'))),
            for (final group in groups)
              _StockWineCard(key: ValueKey(group.entry.wine.id), group: group),
          ]);
        },
      );
}

String _storage(Bottle bottle) =>
    bottle.storageLocation?.trim().isNotEmpty == true
        ? bottle.storageLocation!.trim()
        : '위치 미지정';

class _StockGroup {
  const _StockGroup(this.entry, this.bottles);
  final WineEntry entry;
  final List<Bottle> bottles;
  double get knownCost => bottles.fold(0,
      (total, bottle) => total + (entry.purchaseFor(bottle)?.unitPrice ?? 0));
  int get unknownCost => bottles
      .where((bottle) => entry.purchaseFor(bottle)?.unitPrice == null)
      .length;
  String get locationSummary {
    final counts = <String, int>{};
    for (final bottle in bottles) {
      counts.update(_storage(bottle), (count) => count + 1, ifAbsent: () => 1);
    }
    return counts.entries
        .map((item) => '${item.key} ${item.value}병')
        .join(' · ');
  }
}

class _StockWineCard extends StatelessWidget {
  const _StockWineCard({required this.group, super.key});
  final _StockGroup group;

  @override
  Widget build(BuildContext context) {
    final entry = group.entry;
    final wine = entry.wine;
    final imagePath = wine.imagePath ?? group.bottles.first.imagePath;
    return Card(
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
            key: PageStorageKey('cellar-wine-${wine.id}'),
            leading: SizedBox(
                width: 42,
                height: 56,
                child: imagePath == null
                    ? const Icon(Icons.wine_bar_outlined)
                    : Image.file(File(imagePath),
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.wine_bar_outlined))),
            title: Text('${wine.displayName} ${wine.displayVintage}'),
            subtitle:
                Text('${group.bottles.length}병 · ${group.locationSummary}'),
            childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(wine.producer ?? '생산자 미상'),
              const SizedBox(height: 4),
              Text('구매 원가 ${formatKrw(group.knownCost)}'
                  '${group.unknownCost == 0 ? '' : ' · 가격 미상 ${group.unknownCost}병 제외'}'),
              Wrap(spacing: 8, children: [
                TextButton(
                    onPressed: () => Navigator.of(context).push<void>(
                        MaterialPageRoute(
                            builder: (_) => WineDetailPage(wine: wine))),
                    child: const Text('와인 상세')),
                TextButton(
                    onPressed: () => Navigator.of(context).push<void>(
                        MaterialPageRoute(
                            builder: (_) => PurchasePage(wine: wine))),
                    child: const Text('구매 추가')),
              ]),
              for (var index = 0; index < group.bottles.length; index++)
                _bottleTile(context, group.bottles[index], index + 1),
            ]));
  }

  Widget _bottleTile(BuildContext context, Bottle bottle, int number) {
    final purchase = group.entry.purchaseFor(bottle);
    final origin = switch (bottle.acquisitionKind) {
      AcquisitionKind.purchase => '구매',
      AcquisitionKind.gift => '선물받음',
      AcquisitionKind.other => '기타 취득',
      AcquisitionKind.unknown => '취득 경로 미상',
    };
    final details = purchase == null
        ? '$origin · ${formatKrw(null)}'
        : '${formatDate(purchase.purchaseDate)} · ${purchase.shopName ?? '구매처 미상'}\n'
            '병당 ${formatKrw(purchase.unitPrice)}';
    return ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('병 $number · ${_storage(bottle)} · '
            '${bottle.volumeMl == null ? '용량 미상' : '${bottle.volumeMl} mL'}'),
        subtitle: Text(details),
        trailing: PopupMenuButton<_StockAction>(
            key: ValueKey('stock-actions-${bottle.id}'),
            tooltip: '보유 병 관리',
            onSelected: (action) => _act(context, bottle, action),
            itemBuilder: (_) => const [
                  PopupMenuItem(
                      value: _StockAction.edit, child: Text('보관 위치·병 정보 수정')),
                  PopupMenuItem(
                      value: _StockAction.consume, child: Text('마셨음')),
                  PopupMenuItem(value: _StockAction.gift, child: Text('선물함')),
                  PopupMenuItem(
                      value: _StockAction.returnBottle, child: Text('반품함')),
                ]));
  }

  Future<void> _act(
      BuildContext context, Bottle bottle, _StockAction action) async {
    if (action == _StockAction.edit) {
      await Navigator.of(context).push<void>(MaterialPageRoute(
          builder: (_) =>
              BottlePage(wine: group.entry.wine, initialBottle: bottle)));
      return;
    }
    final status = switch (action) {
      _StockAction.consume => BottleStatus.consumed,
      _StockAction.gift => BottleStatus.gifted,
      _StockAction.returnBottle => BottleStatus.returned,
      _StockAction.edit => throw StateError('Unexpected edit action'),
    };
    final store = MiruvorScope.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('이 병을 ${status.label} 상태로 변경할까요?'),
              content: const Text('보유 목록에서 한 병이 빠집니다. 구매 이력과 시음 기록은 유지됩니다.\n'
                  '상태 변경 날짜는 미상으로 두며 병 정보에서 나중에 수정할 수 있습니다.'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('취소')),
                FilledButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('변경')),
              ],
            ));
    if (confirmed != true || !context.mounted) return;
    try {
      await store.setBottleStatus(bottle.id, status);
      if (messenger.mounted) {
        messenger
            .showSnackBar(SnackBar(content: Text('${status.label} 처리했습니다.')));
      }
    } catch (_) {
      if (messenger.mounted) {
        messenger
            .showSnackBar(const SnackBar(content: Text('병 상태를 변경하지 못했습니다.')));
      }
    }
  }
}

enum _StockAction { edit, consume, gift, returnBottle }
