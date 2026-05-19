import 'package:flutter/material.dart';
import 'package:miruvor/core/models/bottle.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/sample/sample_data.dart';
import 'package:miruvor/core/utils/formatters.dart';
import 'package:miruvor/features/price_check/presentation/price_spectrum.dart';
import 'package:miruvor/features/shared/presentation/section_title.dart';

class WineDetailPage extends StatelessWidget {
  const WineDetailPage({required this.wine, required this.bottle, super.key});

  final Wine wine;
  final Bottle bottle;

  @override
  Widget build(BuildContext context) {
    int? referencePrice;
    for (final price in samplePriceObservations) {
      if (price.wineId == wine.id) {
        referencePrice = price.price;
        break;
      }
    }
    final notes = sampleTastingNotes.where((note) => note.wineId == wine.id);

    return Scaffold(
      appBar: AppBar(title: const Text('Wine Detail')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          _HeroBottle(wine: wine),
          const SizedBox(height: 20),
          const SectionTitle(title: '구매 정보'),
          const SizedBox(height: 12),
          _InfoCard(
            rows: [
              _InfoRow('구매일', formatDate(bottle.purchaseDate)),
              _InfoRow('구매처', bottle.shopName ?? '-'),
              _InfoRow('구매가', formatKrw(bottle.purchasePrice)),
              _InfoRow('보관', bottle.storageLocation ?? '-'),
            ],
          ),
          if (referencePrice != null) ...[
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: PriceSpectrum(
                  purchasePrice: bottle.purchasePrice,
                  referencePrice: referencePrice,
                ),
              ),
            ),
          ],
          const SizedBox(height: 20),
          const SectionTitle(title: '테이스팅 노트'),
          const SizedBox(height: 12),
          for (final note in notes)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${formatDate(note.tastedAt)} · ${note.rating.toStringAsFixed(1)} / 5.0',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
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
            ),
        ],
      ),
    );
  }
}

class _HeroBottle extends StatelessWidget {
  const _HeroBottle({required this.wine});

  final Wine wine;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 72,
              height: 104,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.wine_bar,
                size: 36,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${wine.name} ${wine.displayVintage}',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(wine.producer),
                  const SizedBox(height: 8),
                  Text('${wine.country} · ${wine.region ?? '-'}'),
                  const SizedBox(height: 8),
                  Text(wine.grapeVarieties.join(', ')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.rows});

  final List<_InfoRow> rows;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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
        ),
      ),
    );
  }
}

class _InfoRow {
  const _InfoRow(this.label, this.value);

  final String label;
  final String value;
}
