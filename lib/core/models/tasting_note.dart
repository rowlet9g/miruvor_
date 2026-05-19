class TastingNote {
  const TastingNote({
    required this.id,
    required this.wineId,
    required this.tastedAt,
    required this.rating,
    this.bottleId,
    this.imagePath,
    this.aroma,
    this.palate,
    this.pairing,
    this.acidity,
    this.tannin,
    this.body,
    this.sweetness,
    this.memo,
  });

  final String id;
  final String wineId;
  final String? bottleId;
  final DateTime tastedAt;
  final double rating;
  final String? imagePath;
  final String? aroma;
  final String? palate;
  final String? pairing;
  final int? acidity;
  final int? tannin;
  final int? body;
  final int? sweetness;
  final String? memo;
}
