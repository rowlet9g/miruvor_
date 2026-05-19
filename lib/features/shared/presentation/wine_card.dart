import 'package:flutter/material.dart';
import 'package:miruvor/core/models/bottle.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/utils/formatters.dart';

class WineCard extends StatelessWidget {
  const WineCard({required this.wine, this.bottle, this.onTap, super.key});

  final Wine wine;
  final Bottle? bottle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final regionText = [
      wine.country,
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
              Container(
                width: 48,
                height: 64,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.wine_bar,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${wine.name} ${wine.displayVintage}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      wine.producer,
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
                    if (bottle != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        formatKrw(bottle!.purchasePrice),
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
