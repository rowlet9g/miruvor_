import 'package:miruvor/core/database/app_database.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/models/wine_type.dart';

class WineFilter {
  const WineFilter(
      {this.query = '',
      this.country = '',
      this.type,
      this.minPrice,
      this.maxPrice});
  final String query, country;
  final WineType? type;
  final int? minPrice, maxPrice;
  bool get hasActiveFilters =>
      query.trim().isNotEmpty ||
      country.trim().isNotEmpty ||
      type != null ||
      minPrice != null ||
      maxPrice != null;

  bool matchesEntry(WineEntry entry) {
    if (minPrice == null && maxPrice == null) return matches(entry.wine, null);
    return entry.purchases
        .any((purchase) => matches(entry.wine, purchase.unitPrice));
  }

  bool matches(Wine wine, num? purchasePrice) {
    final normalized = query.trim().toLowerCase();
    final text = [
      wine.name,
      wine.producer,
      wine.country,
      wine.region,
      wine.displayVintage,
      ...wine.grapeVarieties
    ].whereType<String>().join(' ').toLowerCase();
    if (normalized.isNotEmpty && !text.contains(normalized)) return false;
    if (country.trim().isNotEmpty &&
        !(wine.country ?? '')
            .toLowerCase()
            .contains(country.trim().toLowerCase())) {
      return false;
    }
    if (type != null && type != wine.type) return false;
    if ((minPrice != null || maxPrice != null) && purchasePrice == null) {
      return false;
    }
    if (minPrice != null && purchasePrice! < minPrice!) return false;
    if (maxPrice != null && purchasePrice! > maxPrice!) return false;
    return true;
  }
}
