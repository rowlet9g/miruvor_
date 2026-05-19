import 'package:flutter/material.dart';
import 'package:miruvor/core/database/app_database.dart';
import 'package:miruvor/core/models/price_observation.dart';
import 'package:miruvor/core/store/miruvor_scope.dart';
import 'package:miruvor/core/utils/formatters.dart';
import 'package:miruvor/features/price_check/presentation/price_spectrum.dart';

class PriceCheckPage extends StatelessWidget {
  const PriceCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = MiruvorScope.of(context);

    return StreamBuilder<List<WineWithBottle>>(
      stream: store.watchCellar(),
      builder: (context, cellarSnapshot) {
        final cellar = cellarSnapshot.data ?? const <WineWithBottle>[];

        if (cellar.isEmpty) {
          return const Center(child: Text('아직 등록된 와인이 없습니다.'));
        }

        return StreamBuilder<List<PriceObservation>>(
          stream: store.watchPriceObservations(),
          builder: (context, priceSnapshot) {
            final prices = priceSnapshot.data ?? const <PriceObservation>[];

            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              itemCount: cellar.length,
              separatorBuilder: (_, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = cellar[index];
                final reference = _latestReferenceFor(item.wine.id, prices);

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.wine.name} ${item.wine.displayVintage}',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('구매가'),
                            Text(formatKrw(item.bottle.purchasePrice)),
                          ],
                        ),
                        if (reference == null) ...[
                          const SizedBox(height: 12),
                          const Text('아직 기준가가 없습니다.'),
                        ] else ...[
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(reference.sourceName),
                              Text(formatKrw(reference.price)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          PriceSpectrum(
                            purchasePrice: item.bottle.purchasePrice,
                            referencePrice: reference.price,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  PriceObservation? _latestReferenceFor(
    String wineId,
    List<PriceObservation> prices,
  ) {
    for (final price in prices) {
      if (price.wineId == wineId) {
        return price;
      }
    }
    return null;
  }
}
