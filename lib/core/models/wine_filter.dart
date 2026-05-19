import 'package:miruvor/core/models/bottle.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/models/wine_type.dart';

class WineFilter {
  const WineFilter({
    this.query = '',
    this.country = '',
    this.type,
    this.minPrice,
    this.maxPrice,
  });

  final String query;
  final String country;
  final WineType? type;
  final int? minPrice;
  final int? maxPrice;

  bool get hasActiveFilters {
    return query.trim().isNotEmpty ||
        country.trim().isNotEmpty ||
        type != null ||
        minPrice != null ||
        maxPrice != null;
  }

  bool matches(Wine wine, Bottle bottle) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isNotEmpty && !_matchesQuery(wine, normalizedQuery)) {
      return false;
    }

    final normalizedCountry = country.trim().toLowerCase();
    if (normalizedCountry.isNotEmpty &&
        !wine.country.toLowerCase().contains(normalizedCountry)) {
      return false;
    }

    if (type != null && wine.type != type) {
      return false;
    }

    if (minPrice != null && bottle.purchasePrice < minPrice!) {
      return false;
    }

    if (maxPrice != null && bottle.purchasePrice > maxPrice!) {
      return false;
    }

    return true;
  }

  bool _matchesQuery(Wine wine, String normalizedQuery) {
    final haystack = [
      wine.name,
      wine.producer,
      wine.country,
      if (wine.region != null) wine.region!,
      if (wine.vintage != null) wine.vintage.toString(),
      ...wine.grapeVarieties,
    ].join(' ').toLowerCase();

    return haystack.contains(normalizedQuery);
  }
}
