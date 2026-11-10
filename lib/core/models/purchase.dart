class Purchase {
  const Purchase({
    required this.id,
    required this.wineId,
    required this.purchasedQuantity,
    this.purchaseDate,
    this.totalPaidKrw,
    this.shopName,
    this.volumeMl,
    this.note,
  });

  final String id;
  final String wineId;
  final int purchasedQuantity;
  final DateTime? purchaseDate;
  final int? totalPaidKrw;
  final String? shopName;
  final int? volumeMl;
  final String? note;

  double? get unitPrice =>
      totalPaidKrw == null ? null : totalPaidKrw! / purchasedQuantity;
}
