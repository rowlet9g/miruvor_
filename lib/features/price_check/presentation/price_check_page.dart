import 'package:flutter/material.dart';
import 'package:miruvor/core/models/price_observation.dart';
import 'package:miruvor/core/sample/sample_data.dart';
import 'package:miruvor/core/utils/formatters.dart';
import 'package:miruvor/features/price_check/presentation/price_spectrum.dart';

class PriceCheckPage extends StatelessWidget {
  const PriceCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: sampleBottles.length,
      separatorBuilder: (_, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final bottle = sampleBottles[index];
        final wine = sampleWines.firstWhere((wine) => wine.id == bottle.wineId);
        final reference = _referenceFor(wine.id);

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${wine.name} ${wine.displayVintage}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('구매가'),
                    Text(formatKrw(bottle.purchasePrice)),
                  ],
                ),
                if (reference != null) ...[
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
                    purchasePrice: bottle.purchasePrice,
                    referencePrice: reference.price,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  PriceObservation? _referenceFor(String wineId) {
    for (final price in samplePriceObservations) {
      if (price.wineId == wineId) {
        return price;
      }
    }
    return null;
  }
}
