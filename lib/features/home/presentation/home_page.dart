import 'package:flutter/material.dart';
import 'package:miruvor/core/database/app_database.dart';
import 'package:miruvor/core/models/tasting_note.dart';
import 'package:miruvor/features/cellar/presentation/wine_detail_page.dart';
import 'package:miruvor/core/store/miruvor_scope.dart';
import 'package:miruvor/core/utils/formatters.dart';
import 'package:miruvor/features/shared/presentation/section_title.dart';
import 'package:miruvor/features/shared/presentation/wine_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = MiruvorScope.of(context);

    return StreamBuilder<List<WineEntry>>(
      stream: store.watchCatalog(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Padding(
              padding: const EdgeInsets.all(16),
              child: Text('기록을 열지 못했습니다. ${snapshot.error}'));
        }
        final cellar = snapshot.data ?? const <WineEntry>[];
        final openBottles = [
          for (final entry in cellar)
            for (final bottle in entry.bottles.where((b) => b.isInStock))
              WineWithBottle(
                  wine: entry.wine,
                  bottle: bottle,
                  purchase: entry.purchaseFor(bottle)),
        ];
        final knownPrices = openBottles
            .map((b) => b.purchasePrice)
            .whereType<double>()
            .toList();
        final cellarValue = knownPrices.fold<double>(0, (a, b) => a + b);
        final unknownCost = openBottles.length - knownPrices.length;

        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            Row(
              children: [
                Expanded(
                  child: _MetricCard(
                    label: '보유 병수',
                    value: '${openBottles.length}',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MetricCard(
                    label: '보유 병 구매 원가',
                    value: formatKrw(cellarValue),
                  ),
                ),
              ],
            ),
            if (unknownCost > 0) Text('원가 미상 $unknownCost병 제외'),
            const SizedBox(height: 24),
            const SectionTitle(title: '최근 등록'),
            const SizedBox(height: 12),
            if (cellar.isEmpty)
              const _EmptyCard(message: '아직 등록된 와인이 없습니다.')
            else
              WineCard(
                wine: cellar.first.wine,
                bottle: cellar.first.bottles.isEmpty
                    ? null
                    : cellar.first.bottles.first,
                purchasePrice: cellar.first.latestUnitPrice,
                stockCount: cellar.first.stockCount,
                onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (_) => WineDetailPage(wine: cellar.first.wine))),
              ),
            const SizedBox(height: 24),
            const SectionTitle(title: '최근 테이스팅'),
            const SizedBox(height: 12),
            const _TastingSummaryCard(),
          ],
        );
      },
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: textTheme.labelMedium),
            const SizedBox(height: 8),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TastingSummaryCard extends StatelessWidget {
  const _TastingSummaryCard();

  @override
  Widget build(BuildContext context) {
    final store = MiruvorScope.of(context);

    return StreamBuilder<List<TastingNote>>(
      stream: store.watchTastingNotes(),
      builder: (context, snapshot) {
        final notes = snapshot.data ?? const <TastingNote>[];
        if (notes.isEmpty) {
          return const _EmptyCard(message: '아직 작성된 테이스팅 노트가 없습니다.');
        }

        final note = notes.first;
        final textTheme = Theme.of(context).textTheme;

        return FutureBuilder(
          future: store.findWine(note.wineId),
          builder: (context, wineSnapshot) {
            final wine = wineSnapshot.data;

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wine == null
                          ? '알 수 없는 와인'
                          : '${wine.displayName} ${wine.displayVintage}',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${formatDate(note.tastedAt)} · ${note.displayRating}',
                      style: textTheme.bodyMedium,
                    ),
                    if (note.pairing != null) ...[
                      const SizedBox(height: 12),
                      Text('Pairing: ${note.pairing}'),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(message),
      ),
    );
  }
}
