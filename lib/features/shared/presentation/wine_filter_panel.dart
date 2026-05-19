import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miruvor/core/models/wine_type.dart';

class WineFilterPanel extends StatelessWidget {
  const WineFilterPanel({
    required this.queryController,
    required this.countryController,
    required this.minPriceController,
    required this.maxPriceController,
    required this.selectedType,
    required this.hasActiveFilters,
    required this.onChanged,
    required this.onTypeChanged,
    required this.onReset,
    this.queryHint = '이름, 생산자, 국가 검색',
    super.key,
  });

  final TextEditingController queryController;
  final TextEditingController countryController;
  final TextEditingController minPriceController;
  final TextEditingController maxPriceController;
  final WineType? selectedType;
  final bool hasActiveFilters;
  final VoidCallback onChanged;
  final ValueChanged<WineType?> onTypeChanged;
  final VoidCallback onReset;
  final String queryHint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: queryController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: queryHint,
                ),
                textInputAction: TextInputAction.search,
                onChanged: (_) => onChanged(),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              tooltip: '필터 초기화',
              onPressed: hasActiveFilters ? onReset : null,
              icon: const Icon(Icons.restart_alt),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextField(
          controller: countryController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.public),
            hintText: '국가',
          ),
          textInputAction: TextInputAction.next,
          onChanged: (_) => onChanged(),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final type in WineType.values.where((type) {
              return type != WineType.other;
            }))
              FilterChip(
                label: Text(type.label),
                selected: selectedType == type,
                onSelected: (selected) {
                  onTypeChanged(selected ? type : null);
                },
              ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: minPriceController,
                decoration: const InputDecoration(labelText: '최소 가격'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (_) => onChanged(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: maxPriceController,
                decoration: const InputDecoration(labelText: '최대 가격'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (_) => onChanged(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
