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
  bool _archived = false;

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

    return StreamBuilder<List<WineEntry>>(
      stream: store.watchCatalog(filter: filter, archived: _archived),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Padding(
              padding: const EdgeInsets.all(16),
              child: Text('기록을 열지 못했습니다. ${snapshot.error}'));
        }
        final cellar = snapshot.data ?? const <WineEntry>[];

        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            SwitchListTile(
                title: const Text('보관한 와인 보기'),
                value: _archived,
                onChanged: (v) => setState(() => _archived = v)),
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
                  bottle: item.bottles.isEmpty ? null : item.bottles.first,
                  purchasePrice: item.latestUnitPrice,
                  stockCount: item.stockCount,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => WineDetailPage(wine: item.wine),
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
