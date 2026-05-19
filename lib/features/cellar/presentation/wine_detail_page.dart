import 'dart:io';

import 'package:flutter/material.dart';
import 'package:miruvor/core/models/bottle.dart';
import 'package:miruvor/core/models/price_observation.dart';
import 'package:miruvor/core/models/tasting_note.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/store/miruvor_scope.dart';
import 'package:miruvor/core/utils/formatters.dart';
import 'package:miruvor/features/cellar/presentation/add_wine_page.dart';
import 'package:miruvor/features/price_check/presentation/price_spectrum.dart';
import 'package:miruvor/features/shared/presentation/section_title.dart';

class WineDetailPage extends StatelessWidget {
  const WineDetailPage({required this.wine, required this.bottle, super.key});

  final Wine wine;
  final Bottle bottle;

  @override
  Widget build(BuildContext context) {
    final store = MiruvorScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wine Detail'),
        actions: [
          IconButton(
            tooltip: '수정',
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => _editWine(context),
          ),
          IconButton(
            tooltip: '삭제',
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _deleteWine(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          _HeroBottle(wine: wine, bottle: bottle),
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
          FutureBuilder<PriceObservation?>(
            future: store.latestPriceForWine(wine.id),
            builder: (context, snapshot) {
              final reference = snapshot.data;
              if (reference == null) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: PriceSpectrum(
                      purchasePrice: bottle.purchasePrice,
                      referencePrice: reference.price,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const SectionTitle(title: '테이스팅 노트'),
          const SizedBox(height: 12),
          FutureBuilder<List<TastingNote>>(
            future: store.notesForWine(wine.id),
            builder: (context, snapshot) {
              final notes = snapshot.data ?? const <TastingNote>[];
              if (notes.isEmpty) {
                return const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('아직 작성된 테이스팅 노트가 없습니다.'),
                  ),
                );
              }

              return Column(
                children: [
                  for (final note in notes)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _TastingNoteCard(note: note),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _editWine(BuildContext context) async {
    final store = MiruvorScope.of(context);
    final reference = await store.latestPriceForWine(wine.id);
    if (!context.mounted) {
      return;
    }

    final saved = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => AddWinePage(
          initialWine: wine,
          initialBottle: bottle,
          initialReferencePrice: reference,
        ),
      ),
    );

    if (saved == true && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _deleteWine(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('와인 삭제'),
          content: const Text('이 구매 기록과 연결된 가격 정보, 테이스팅 노트가 함께 삭제됩니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('취소'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('삭제'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    final store = MiruvorScope.of(context);
    await store.deleteWinePurchase(wineId: wine.id, bottleId: bottle.id);

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}

class _HeroBottle extends StatelessWidget {
  const _HeroBottle({required this.wine, required this.bottle});

  final Wine wine;
  final Bottle bottle;

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
                child: bottle.imagePath == null
                    ? _FallbackBottleIcon()
                    : Image.file(
                        File(bottle.imagePath!),
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
              '${formatDate(note.tastedAt)} · ${note.rating.toStringAsFixed(1)} / 5.0',
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
