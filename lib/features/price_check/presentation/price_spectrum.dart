import 'package:flutter/material.dart';

class PriceSpectrum extends StatelessWidget {
  const PriceSpectrum({
    required this.purchasePrice,
    required this.referencePrice,
    super.key,
  });

  final int purchasePrice;
  final int referencePrice;

  @override
  Widget build(BuildContext context) {
    final ratio = referencePrice == 0 ? 1.0 : purchasePrice / referencePrice;
    final position = ((ratio - 0.7) / 0.6).clamp(0.0, 1.0);
    final label = _labelForRatio(ratio);

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
            Text(label),
          ],
        ),
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
          children: [Text('저렴'), Text('보통'), Text('높음')],
        ),
      ],
    );
  }

  String _labelForRatio(double ratio) {
    if (ratio <= 0.9) {
      return '기준가 대비 저렴';
    }
    if (ratio >= 1.1) {
      return '기준가 대비 높음';
    }
    return '기준가 근처';
  }
}
