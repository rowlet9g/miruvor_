import 'package:flutter/material.dart';
import 'package:miruvor/core/database/app_database.dart';
import 'package:miruvor/core/models/wine_filter.dart';
import 'package:miruvor/core/models/wine_type.dart';
import 'package:miruvor/core/store/miruvor_scope.dart';
import 'package:miruvor/features/cellar/presentation/wine_detail_page.dart';
import 'package:miruvor/features/shared/presentation/wine_card.dart';
import 'package:miruvor/features/shared/presentation/wine_filter_panel.dart';

class CellarPage extends StatefulWidget {
  const CellarPage({super.key});

  @override
  State<CellarPage> createState() => _CellarPageState();
}

class _CellarPageState extends State<CellarPage> {
  final _queryController = TextEditingController();
  final _countryController = TextEditingController();
  final _minPriceController = TextEditingController();
  final _maxPriceController = TextEditingController();

  WineType? _selectedType;

  WineFilter get _filter {
    return WineFilter(
      query: _queryController.text,
      country: _countryController.text,
      type: _selectedType,
      minPrice: _parseInt(_minPriceController.text),
      maxPrice: _parseInt(_maxPriceController.text),
    );
  }

  @override
  void dispose() {
    _queryController.dispose();
    _countryController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = MiruvorScope.of(context);
    final filter = _filter;

    return StreamBuilder<List<WineWithBottle>>(
      stream: store.watchCellar(filter: filter),
      builder: (context, snapshot) {
        final cellar = snapshot.data ?? const <WineWithBottle>[];

        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            WineFilterPanel(
              queryController: _queryController,
              countryController: _countryController,
              minPriceController: _minPriceController,
              maxPriceController: _maxPriceController,
              selectedType: _selectedType,
              hasActiveFilters: filter.hasActiveFilters,
              onChanged: _refresh,
              onTypeChanged: (type) {
                setState(() => _selectedType = type);
              },
              onReset: _resetFilters,
            ),
            const SizedBox(height: 16),
            if (cellar.isEmpty)
              _EmptyResultsCard(hasActiveFilters: filter.hasActiveFilters)
            else
              for (final item in cellar) ...[
                WineCard(
                  wine: item.wine,
                  bottle: item.bottle,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => WineDetailPage(
                          wine: item.wine,
                          bottle: item.bottle,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
              ],
          ],
        );
      },
    );
  }

  void _refresh() {
    setState(() {});
  }

  void _resetFilters() {
    _queryController.clear();
    _countryController.clear();
    _minPriceController.clear();
    _maxPriceController.clear();
    setState(() => _selectedType = null);
  }

  int? _parseInt(String value) {
    if (value.trim().isEmpty) {
      return null;
    }

    return int.tryParse(value.trim());
  }
}

class _EmptyResultsCard extends StatelessWidget {
  const _EmptyResultsCard({required this.hasActiveFilters});

  final bool hasActiveFilters;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          hasActiveFilters ? '조건에 맞는 와인이 없습니다.' : '아직 등록된 와인이 없습니다.',
        ),
      ),
    );
  }
}
