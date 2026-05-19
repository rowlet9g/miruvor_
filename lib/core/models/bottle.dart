class Bottle {
  const Bottle({
    required this.id,
    required this.wineId,
    required this.purchaseDate,
    required this.purchasePrice,
    this.shopName,
    this.imagePath,
    this.storageLocation,
    this.isConsumed = false,
  });

  final String id;
  final String wineId;
  final DateTime purchaseDate;
  final int purchasePrice;
  final String? shopName;
  final String? imagePath;
  final String? storageLocation;
  final bool isConsumed;
}
