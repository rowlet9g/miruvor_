import 'package:miruvor/core/models/wine_type.dart';

class Wine {
  const Wine({
    required this.id,
    required this.name,
    required this.producer,
    required this.country,
    this.region,
    this.vintage,
    this.type = WineType.red,
    this.grapeVarieties = const [],
  });

  final String id;
  final String name;
  final String producer;
  final String country;
  final String? region;
  final int? vintage;
  final WineType type;
  final List<String> grapeVarieties;

  String get displayVintage => vintage?.toString() ?? 'NV';
}
