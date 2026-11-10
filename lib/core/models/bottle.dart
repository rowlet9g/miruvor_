enum AcquisitionKind { purchase, gift, other, unknown }

enum BottleStatus {
  inStock('보유'),
  consumed('소비'),
  gifted('선물함'),
  returned('반품');

  const BottleStatus(this.label);
  final String label;
}

class Bottle {
  const Bottle({
    required this.id,
    required this.wineId,
    this.purchaseId,
    this.acquisitionKind = AcquisitionKind.unknown,
    this.acquiredAt,
    this.volumeMl,
    this.status = BottleStatus.inStock,
    this.statusChangedAt,
    this.imagePath,
    this.storageLocation,
  });

  final String id;
  final String wineId;
  final String? purchaseId;
  final AcquisitionKind acquisitionKind;
  final DateTime? acquiredAt;
  final int? volumeMl;
  final BottleStatus status;
  final DateTime? statusChangedAt;
  final String? imagePath;
  final String? storageLocation;

  bool get isConsumed => status == BottleStatus.consumed;
  bool get isInStock => status == BottleStatus.inStock;

  Bottle withStatus(BottleStatus next, DateTime? changedAt) => Bottle(
        id: id,
        wineId: wineId,
        purchaseId: purchaseId,
        acquisitionKind: acquisitionKind,
        acquiredAt: acquiredAt,
        volumeMl: volumeMl,
        status: next,
        statusChangedAt: changedAt,
        imagePath: imagePath,
        storageLocation: storageLocation,
      );
}
