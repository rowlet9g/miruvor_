import 'package:flutter/material.dart';
import 'package:miruvor/core/sample/sample_data.dart';
import 'package:miruvor/features/cellar/presentation/wine_detail_page.dart';
import 'package:miruvor/features/shared/presentation/wine_card.dart';

class CellarPage extends StatelessWidget {
  const CellarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: sampleBottles.length + 1,
      separatorBuilder: (_, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == 0) {
          return const _CellarFilters();
        }

        final bottle = sampleBottles[index - 1];
        final wine = sampleWines.firstWhere((wine) => wine.id == bottle.wineId);

        return WineCard(
          wine: wine,
          bottle: bottle,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) =>
                    WineDetailPage(wine: wine, bottle: bottle),
              ),
            );
          },
        );
      },
    );
  }
}

class _CellarFilters extends StatelessWidget {
  const _CellarFilters();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: '이름, 생산자, 국가 검색',
          ),
          textInputAction: TextInputAction.search,
          onChanged: (_) {},
        ),
        const SizedBox(height: 12),
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _FilterChip(label: 'Red'),
            _FilterChip(label: 'White'),
            _FilterChip(label: 'Sparkling'),
            _FilterChip(label: 'Under 50k'),
          ],
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return FilterChip(label: Text(label), selected: false, onSelected: (_) {});
  }
}
