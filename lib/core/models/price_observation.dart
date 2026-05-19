class PriceObservation {
  const PriceObservation({
    required this.id,
    required this.wineId,
    required this.sourceName,
    required this.price,
    required this.observedAt,
    this.url,
    this.note,
    this.isInStock,
  });

  final String id;
  final String wineId;
  final String sourceName;
  final int price;
  final DateTime observedAt;
  final String? url;
  final String? note;
  final bool? isInStock;
}
