import 'package:flutter/material.dart';
import 'package:miruvor/core/models/price_analysis.dart';
import 'package:miruvor/core/utils/formatters.dart';

class PriceSpectrum extends StatelessWidget {
  const PriceSpectrum({
    required this.analysis,
    super.key,
  });

  final PriceAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    final ratio = analysis.ratioToAverage ?? 1.0;
    final position = ((ratio - 0.7) / 0.6).clamp(0.0, 1.0);
    final averagePrice = analysis.averagePrice;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '가격 합리성',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(analysis.judgement.label),
          ],
        ),
        if (averagePrice != null) ...[
          const SizedBox(height: 4),
          Text(
            '평균가 ${formatKrw(averagePrice)} 대비 ${(ratio * 100).round()}%',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF3465A4),
                        Color(0xFFE7D37F),
                        Color(0xFFB33A3A),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: (constraints.maxWidth - 14) * position,
                  top: -3,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onSurface,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('청: 저렴'), Text('적정'), Text('적: 높음')],
        ),
      ],
    );
  }
}
