import 'dart:io';

import 'package:flutter/material.dart';
import 'package:miruvor/core/models/bottle.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/utils/formatters.dart';

class WineCard extends StatelessWidget {
  const WineCard(
      {required this.wine,
      this.bottle,
      this.purchasePrice,
      this.stockCount,
      this.onTap,
      super.key});

  final Wine wine;
  final Bottle? bottle;
  final num? purchasePrice;
  final int? stockCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final regionText = [
      wine.country ?? '국가 미상',
      if (wine.region != null) wine.region!,
    ].join(' · ');

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 48,
                  height: 64,
                  child: _BottleImage(
                      imagePath: wine.imagePath ?? bottle?.imagePath),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${wine.displayName} ${wine.displayVintage}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      wine.producer ?? '생산자 미상',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      regionText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall,
                    ),
                    if (stockCount != null) ...[
                      const SizedBox(height: 8),
                      Text('보유 $stockCount병'),
                    ],
                    if (purchasePrice != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        formatKrw(purchasePrice),
                        style: textTheme.labelLarge,
                      ),
                    ],
                  ],
                ),
              ),
              if (onTap != null) const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottleImage extends StatelessWidget {
  const _BottleImage({required this.imagePath});

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      return Image.file(
        File(imagePath!),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _FallbackBottleIcon(),
      );
    }

    return _FallbackBottleIcon();
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
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}
