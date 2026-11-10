import 'package:miruvor/core/models/wine_type.dart';

enum VintageKind { year, nonVintage, unknown }

class Wine {
  const Wine({
    required this.id,
    this.name,
    this.producer,
    this.country,
    this.region,
    this.vintage,
    VintageKind? vintageKind,
    this.type,
    this.grapeVarieties = const [],
    this.imagePath,
    this.isWishlisted = false,
    this.isArchived = false,
  }) : vintageKind = vintageKind ??
            (vintage == null ? VintageKind.unknown : VintageKind.year);

  final String id;
  final String? name;
  final String? producer;
  final String? country;
  final String? region;
  final int? vintage;
  final VintageKind vintageKind;
  final WineType? type;
  final List<String> grapeVarieties;
  final String? imagePath;
  final bool isWishlisted;
  final bool isArchived;

  String get displayName => name ?? '이름 미확인';
  String get displayVintage => switch (vintageKind) {
        VintageKind.year => vintage.toString(),
        VintageKind.nonVintage => 'NV',
        VintageKind.unknown => '빈티지 미상',
      };
}
