import 'dart:io';

import 'package:flutter/material.dart';
import 'package:miruvor/core/database/app_database.dart';
import 'package:miruvor/core/models/bottle.dart';
import 'package:miruvor/core/models/purchase.dart';
import 'package:miruvor/core/models/price_analysis.dart';
import 'package:miruvor/core/models/price_observation.dart';
import 'package:miruvor/core/models/tasting_note.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/store/miruvor_scope.dart';
import 'package:miruvor/core/utils/formatters.dart';
import 'package:miruvor/features/cellar/presentation/add_wine_page.dart';
import 'package:miruvor/features/cellar/presentation/bottle_page.dart';
import 'package:miruvor/features/cellar/presentation/purchase_page.dart';
import 'package:miruvor/features/tasting_notes/presentation/tasting_notes_page.dart';
import 'package:miruvor/features/price_check/presentation/price_spectrum.dart';
import 'package:miruvor/features/shared/presentation/section_title.dart';

class WineDetailPage extends StatelessWidget {
  const WineDetailPage({required this.wine, super.key});
  final Wine wine;

  @override
  Widget build(BuildContext context) {
    final store = MiruvorScope.of(context);
    return StreamBuilder<List<WineEntry>>(
      stream: store.database.watchCatalog(),
      builder: (context, snapshot) {
        WineEntry? entry;
        for (final item in snapshot.data ?? <WineEntry>[]) {
          if (item.wine.id == wine.id) entry = item;
        }
        if (entry == null) {
          return Scaffold(
              appBar: AppBar(title: const Text('Wine Detail')),
              body: Center(
                  child: Text(snapshot.hasError
                      ? '기록을 열지 못했습니다.'
                      : snapshot.hasData
                          ? '와인 기록이 없습니다.'
                          : '불러오는 중')));
        }
        final current = entry;
        final currentWine = current.wine;
        return Scaffold(
          appBar: AppBar(title: const Text('Wine Detail'), actions: [
            IconButton(
                tooltip: '와인 정보 수정',
                icon: const Icon(Icons.edit_outlined),
                onPressed: () =>
                    _open(context, AddWinePage(initialWine: currentWine))),
            IconButton(
                tooltip: '와인 전체 영구 삭제',
                icon: const Icon(Icons.delete_forever_outlined),
                onPressed: () => _deleteWine(context)),
          ]),
          body: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              children: [
                _HeroBottle(
                    wine: currentWine,
                    bottle:
                        current.bottles.isEmpty ? null : current.bottles.first),
                const SizedBox(height: 12),
                Text(
                    '보유 ${current.stockCount}병 · 구매 ${current.purchases.length}건'),
                Wrap(spacing: 8, children: [
                  TextButton.icon(
                      icon: const Icon(Icons.shopping_bag_outlined),
                      label: const Text('구매 추가'),
                      onPressed: () =>
                          _open(context, PurchasePage(wine: currentWine))),
                  TextButton.icon(
                      icon: const Icon(Icons.card_giftcard),
                      label: const Text('구매 없이 병 추가'),
                      onPressed: () =>
                          _open(context, BottlePage(wine: currentWine))),
                  TextButton.icon(
                      icon: const Icon(Icons.edit_note),
                      label: const Text('시음 추가'),
                      onPressed: () => _open(context,
                          AddTastingNotePage(initialWineId: currentWine.id))),
                  TextButton(
                      onPressed: current.stockCount > 0
                          ? null
                          : () => _perform(
                              context,
                              () => store.setArchived(
                                  currentWine.id, !currentWine.isArchived)),
                      child:
                          Text(currentWine.isArchived ? '기록 다시 표시' : '기록 숨기기')),
                ]),
                const SizedBox(height: 12),
                const SectionTitle(title: '구매 이력'),
                if (current.purchases.isEmpty)
                  const Padding(
                      padding: EdgeInsets.all(12), child: Text('구매 기록 없음')),
                for (final purchase in current.purchases)
                  Card(
                      key: ValueKey('purchase-${purchase.id}'),
                      child: ListTile(
                        title: Text(
                            '${purchase.purchasedQuantity}병 · 총액 ${formatKrw(purchase.totalPaidKrw)}'),
                        subtitle: Text(
                            '${formatDate(purchase.purchaseDate)} · ${purchase.shopName ?? '구매처 미상'}\n'
                            '병당 ${formatKrw(purchase.unitPrice)} · ${purchase.volumeMl == null ? '용량 미상' : '${purchase.volumeMl}mL'}'
                            '${purchase.note == null ? '' : '\n${purchase.note}'}'),
                        isThreeLine: true,
                        trailing:
                            Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                              tooltip: '구매 수정',
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () => _open(
                                  context,
                                  PurchasePage(
                                      wine: currentWine,
                                      initialPurchase: purchase))),
                          IconButton(
                              tooltip: '구매 삭제',
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () =>
                                  _deletePurchase(context, purchase)),
                        ]),
                      )),
                const SizedBox(height: 12),
                ExpansionTile(
                    title: Text('병 기록 ${current.bottles.length}개'),
                    children: [
                      if (current.bottles.isEmpty)
                        const ListTile(title: Text('병 기록 없음')),
                      for (var index = 0;
                          index < current.bottles.length;
                          index++)
                        _bottleTile(context, currentWine,
                            current.bottles[index], index + 1),
                    ]),
                const SizedBox(height: 12),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SectionTitle(title: '가격 판단'),
                      TextButton.icon(
                          icon: const Icon(Icons.add_chart_outlined),
                          label: const Text('가격 추가'),
                          onPressed: () => showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              builder: (_) =>
                                  _PriceObservationSheet(wineId: wine.id))),
                    ]),
                StreamBuilder<List<PriceObservation>>(
                  stream: store.watchPriceObservationsForWine(wine.id),
                  builder: (context, snapshot) {
                    final observations = snapshot.data ?? <PriceObservation>[];
                    final analysis = PriceAnalysis(
                        purchasePrice: current.latestUnitPrice,
                        observations: observations);
                    if (observations.isEmpty) {
                      return const Card(
                          child: Padding(
                              padding: EdgeInsets.all(16),
                              child:
                                  Text('아직 가격 관측치가 없습니다. 판매처 가격을 추가해 보세요.')));
                    }
                    return Column(children: [
                      if (analysis.hasMarketData)
                        Card(
                            child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(children: [
                                  const Text('최근 구매 병당가 기준'),
                                  PriceSpectrum(analysis: analysis),
                                  _InfoRows(rows: [
                                    _InfoRow(
                                        '최저가', formatKrw(analysis.minPrice)),
                                    _InfoRow('평균가',
                                        formatKrw(analysis.averagePrice)),
                                    _InfoRow(
                                        '최고가', formatKrw(analysis.maxPrice)),
                                  ]),
                                ]))),
                      if (observations.any((o) => o.price == 0))
                        const Text('기존 0원 관측치는 비교에서 제외됩니다. 가격을 정정해 주세요.'),
                      for (final observation in observations)
                        _PriceObservationCard(observation: observation),
                    ]);
                  },
                ),
                const SizedBox(height: 20),
                const SectionTitle(title: '테이스팅 노트'),
                StreamBuilder<List<TastingNote>>(
                  stream: store.watchTastingNotes(),
                  builder: (context, snapshot) {
                    final notes = (snapshot.data ?? <TastingNote>[])
                        .where((n) => n.wineId == wine.id)
                        .toList();
                    if (notes.isEmpty) {
                      return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('아직 작성된 테이스팅 노트가 없습니다.'));
                    }
                    return Column(children: [
                      for (final note in notes) _TastingNoteCard(note: note)
                    ]);
                  },
                ),
              ]),
        );
      },
    );
  }

  Widget _bottleTile(
          BuildContext context, Wine current, Bottle bottle, int number) =>
      ListTile(
        key: ValueKey('bottle-${bottle.id}'),
        title: Text('병 $number · ${bottle.status.label}'),
        subtitle: Text('${bottle.purchaseId == null ? '구매 연결 없음' : '구매 연결됨'} · '
            '${bottle.storageLocation ?? '보관 위치 미상'}'),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
              tooltip: '병 수정',
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => _open(
                  context, BottlePage(wine: current, initialBottle: bottle))),
          IconButton(
              tooltip: '병 기록 삭제',
              icon: const Icon(Icons.delete_outline),
              onPressed: () async {
                if (!await _confirm(context, '병 기록 삭제',
                    '오등록한 병만 삭제합니다. 연결된 시음 노트와 구매 이력은 유지됩니다.\n마심·선물·반품은 병 상태를 변경해 주세요.')) {
                  return;
                }
                if (context.mounted) {
                  await _perform(context,
                      () => MiruvorScope.of(context).deleteBottle(bottle.id));
                }
              }),
        ]),
      );

  Future<void> _open(BuildContext context, Widget page) =>
      Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));

  Future<void> _deletePurchase(BuildContext context, Purchase purchase) async {
    if (!await _confirm(context, '구매 기록 삭제',
        '이 구매의 날짜·구매처·수량·금액을 삭제합니다. 병과 보유 수량, 시음 노트, 참고 가격은 유지됩니다.')) {
      return;
    }
    if (context.mounted) {
      await _perform(
          context, () => MiruvorScope.of(context).deletePurchase(purchase.id));
    }
  }

  Future<void> _deleteWine(BuildContext context) async {
    final store = MiruvorScope.of(context);
    final impact = await store.previewWineDeletion(wine.id);
    if (!context.mounted) return;
    final confirmed = await _confirm(
        context,
        '와인 전체 영구 삭제',
        '이 와인과 구매 ${impact.purchases}건, 병 ${impact.bottles}개, 시음 노트 ${impact.notes}건, '
            '참고 가격 ${impact.prices}건을 모두 삭제합니다.\n'
            '다른 기록에서 참조하지 않는 사진 ${impact.unreferencedImages.length}개도 정리합니다.\n'
            '이 동작은 되돌릴 수 없습니다.');
    if (!confirmed || !context.mounted) return;
    final success = await _perform(
        context, () => store.deleteWine(wine.id, expected: impact));
    if (success && context.mounted) Navigator.of(context).pop();
  }

  Future<bool> _confirm(
          BuildContext context, String title, String message) async =>
      await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(title),
                content: Text(message),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('취소')),
                  FilledButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('삭제')),
                ],
              )) ??
      false;

  Future<bool> _perform(
      BuildContext context, Future<void> Function() action) async {
    try {
      await action();
      return true;
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error is StateError
                ? error.message.toString()
                : '작업하지 못했습니다. 기록을 다시 확인해 주세요.')));
      }
      return false;
    }
  }
}

class _HeroBottle extends StatelessWidget {
  const _HeroBottle({required this.wine, this.bottle});

  final Wine wine;
  final Bottle? bottle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final grapeText =
        wine.grapeVarieties.isEmpty ? '품종 미입력' : wine.grapeVarieties.join(', ');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 72,
                height: 104,
                child: (wine.imagePath ?? bottle?.imagePath) == null
                    ? _FallbackBottleIcon()
                    : Image.file(
                        File((wine.imagePath ?? bottle?.imagePath)!),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _FallbackBottleIcon();
                        },
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${wine.displayName} ${wine.displayVintage}',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(wine.producer ?? '생산자 미상'),
                  const SizedBox(height: 8),
                  Text('${wine.country} · ${wine.region ?? '-'}'),
                  const SizedBox(height: 8),
                  Text(grapeText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FallbackBottleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Icon(
        Icons.wine_bar,
        size: 36,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}

class _TastingNoteCard extends StatelessWidget {
  const _TastingNoteCard({required this.note});

  final TastingNote note;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${formatDate(note.tastedAt)} · ${note.displayRating}',
              style: Theme.of(context).textTheme.titleSmall,
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
            if (note.memo != null) Text(note.memo!),
            if (note.aroma != null) ...[
              const SizedBox(height: 8),
              Text('Aroma: ${note.aroma}'),
            ],
            if (note.palate != null) ...[
              const SizedBox(height: 8),
              Text('Palate: ${note.palate}'),
            ],
            if (note.pairing != null) ...[
              const SizedBox(height: 8),
              Text('Pairing: ${note.pairing}'),
            ],
          ],
        ),
      ),
    );
  }
}

class _PriceObservationCard extends StatelessWidget {
  const _PriceObservationCard({required this.observation});

  final PriceObservation observation;

  @override
  Widget build(BuildContext context) {
    final store = MiruvorScope.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    observation.sourceName,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(formatDate(observation.observedAt)),
                  if (observation.note != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      observation.note!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(formatKrw(observation.price)),
            IconButton(
              tooltip: '가격 수정',
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => _editObservation(context),
            ),
            IconButton(
              tooltip: '가격 삭제',
              icon: const Icon(Icons.delete_outline),
              onPressed: () => store.deletePriceObservation(observation.id),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editObservation(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _PriceObservationSheet(
        wineId: observation.wineId,
        initialObservation: observation,
      ),
    );
  }
}

class _PriceObservationSheet extends StatefulWidget {
  const _PriceObservationSheet({
    required this.wineId,
    this.initialObservation,
  });

  final String wineId;
  final PriceObservation? initialObservation;

  @override
  State<_PriceObservationSheet> createState() => _PriceObservationSheetState();
}

class _PriceObservationSheetState extends State<_PriceObservationSheet> {
  final _formKey = GlobalKey<FormState>();
  final _sourceController = TextEditingController();
  final _priceController = TextEditingController();
  final _urlController = TextEditingController();
  final _noteController = TextEditingController();

  bool _isSaving = false;
  bool get _isEditing => widget.initialObservation != null;

  @override
  void initState() {
    super.initState();

    final observation = widget.initialObservation;
    if (observation != null) {
      _sourceController.text = observation.sourceName;
      _priceController.text = observation.price.toString();
      _urlController.text = observation.url ?? '';
      _noteController.text = observation.note ?? '';
    }
  }

  @override
  void dispose() {
    _sourceController.dispose();
    _priceController.dispose();
    _urlController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, bottomInset + 16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _isEditing ? '가격 관측치 수정' : '가격 관측치 추가',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _sourceController,
                decoration: const InputDecoration(labelText: '판매처'),
                textInputAction: TextInputAction.next,
                validator: _required,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: '판매 가격'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: _requiredInt,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(labelText: 'URL'),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: '메모'),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
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
      final initialObservation = widget.initialObservation;
      if (initialObservation == null) {
        await store.addPriceObservation(
          wineId: widget.wineId,
          sourceName: _sourceController.text.trim(),
          price: int.parse(_priceController.text.trim()),
          observedAt: DateTime.now(),
          url: _nullableText(_urlController),
          note: _nullableText(_noteController),
        );
      } else {
        await store.updatePriceObservation(
          id: initialObservation.id,
          wineId: initialObservation.wineId,
          sourceName: _sourceController.text.trim(),
          price: int.parse(_priceController.text.trim()),
          observedAt: initialObservation.observedAt,
          url: _nullableText(_urlController),
          note: _nullableText(_noteController),
          isInStock: initialObservation.isInStock,
          volumeMl: initialObservation.volumeMl,
        );
      }

      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('가격을 저장하지 못했습니다.')));
    }
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
    if ((int.tryParse(value.trim()) ?? 0) <= 0) {
      return '0보다 큰 가격을 입력해 주세요.';
    }
    return null;
  }

  String? _nullableText(TextEditingController controller) {
    final value = controller.text.trim();
    return value.isEmpty ? null : value;
  }
}

class _InfoRows extends StatelessWidget {
  const _InfoRows({required this.rows});

  final List<_InfoRow> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final row in rows)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(row.label),
                Flexible(
                  child: Text(
                    row.value,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _InfoRow {
  const _InfoRow(this.label, this.value);

  final String label;
  final String value;
}
