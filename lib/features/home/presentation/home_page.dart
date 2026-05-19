import 'package:flutter/material.dart';
import 'package:miruvor/core/sample/sample_data.dart';
import 'package:miruvor/core/utils/formatters.dart';
import 'package:miruvor/features/shared/presentation/section_title.dart';
import 'package:miruvor/features/shared/presentation/wine_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cellarValue = sampleBottles.fold<int>(
      0,
      (sum, bottle) => sum + bottle.purchasePrice,
    );
    final openBottles = sampleBottles.where((bottle) => !bottle.isConsumed);

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
              child: _MetricCard(label: '구매 총액', value: formatKrw(cellarValue)),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionTitle(title: '최근 등록'),
        const SizedBox(height: 12),
        WineCard(wine: sampleWines.first, bottle: sampleBottles.first),
        const SizedBox(height: 24),
        const SectionTitle(title: '최근 테이스팅'),
        const SizedBox(height: 12),
        _TastingSummaryCard(),
      ],
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
  @override
  Widget build(BuildContext context) {
    final note = sampleTastingNotes.first;
    final wine = sampleWines.firstWhere((wine) => wine.id == note.wineId);
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${wine.name} ${wine.displayVintage}',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${formatDate(note.tastedAt)} · ${note.rating.toStringAsFixed(1)} / 5.0',
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
  }
}
