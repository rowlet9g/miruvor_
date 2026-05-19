import 'package:flutter/material.dart';
import 'package:miruvor/core/sample/sample_data.dart';
import 'package:miruvor/features/shared/presentation/wine_card.dart';

class WineSearchPage extends StatelessWidget {
  const WineSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: sampleWines.length + 1,
      separatorBuilder: (_, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == 0) {
          return const _SearchControls();
        }

        final wine = sampleWines[index - 1];
        return WineCard(wine: wine);
      },
    );
  }
}

class _SearchControls extends StatelessWidget {
  const _SearchControls();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: '와인 이름 검색',
          ),
          textInputAction: TextInputAction.search,
          onChanged: (_) {},
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: '국가'),
                items: const [
                  DropdownMenuItem(value: 'france', child: Text('France')),
                  DropdownMenuItem(value: 'italy', child: Text('Italy')),
                  DropdownMenuItem(value: 'usa', child: Text('USA')),
                  DropdownMenuItem(value: 'korea', child: Text('Korea')),
                ],
                onChanged: (_) {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: '종류'),
                items: const [
                  DropdownMenuItem(value: 'red', child: Text('Red')),
                  DropdownMenuItem(value: 'white', child: Text('White')),
                  DropdownMenuItem(value: 'rose', child: Text('Rose')),
                  DropdownMenuItem(
                    value: 'sparkling',
                    child: Text('Sparkling'),
                  ),
                ],
                onChanged: (_) {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(labelText: '최소 가격'),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(labelText: '최대 가격'),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
