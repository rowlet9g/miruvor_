import 'package:miruvor/core/models/bottle.dart';
import 'package:miruvor/core/models/price_observation.dart';
import 'package:miruvor/core/models/tasting_note.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/models/wine_type.dart';

final sampleWines = <Wine>[
  const Wine(
    id: 'wine-001',
    name: 'Chateau Musar',
    producer: 'Chateau Musar',
    country: 'Lebanon',
    region: 'Bekaa Valley',
    vintage: 2017,
    type: WineType.red,
    grapeVarieties: ['Cabernet Sauvignon', 'Cinsault', 'Carignan'],
  ),
  const Wine(
    id: 'wine-002',
    name: 'Riesling Trocken',
    producer: 'Keller',
    country: 'Germany',
    region: 'Rheinhessen',
    vintage: 2021,
    type: WineType.white,
    grapeVarieties: ['Riesling'],
  ),
];

final sampleBottles = <Bottle>[
  Bottle(
    id: 'bottle-001',
    wineId: 'wine-001',
    purchaseDate: DateTime(2026, 5, 12),
    purchasePrice: 76000,
    shopName: 'Wine shop',
    storageLocation: 'Cellar A',
  ),
  Bottle(
    id: 'bottle-002',
    wineId: 'wine-002',
    purchaseDate: DateTime(2026, 5, 3),
    purchasePrice: 52000,
    shopName: 'Daily deal',
    storageLocation: 'Fridge',
  ),
];

final samplePriceObservations = <PriceObservation>[
  PriceObservation(
    id: 'price-001',
    wineId: 'wine-001',
    sourceName: 'Manual reference',
    price: 89000,
    observedAt: DateTime(2026, 5, 15),
    note: 'User-entered baseline price',
  ),
  PriceObservation(
    id: 'price-002',
    wineId: 'wine-002',
    sourceName: 'Manual reference',
    price: 49000,
    observedAt: DateTime(2026, 5, 15),
    note: 'User-entered baseline price',
  ),
];

final sampleTastingNotes = <TastingNote>[
  TastingNote(
    id: 'note-001',
    wineId: 'wine-001',
    bottleId: 'bottle-001',
    tastedAt: DateTime(2026, 5, 18),
    rating: 4.2,
    aroma: 'Dried fruit, leather, spice',
    palate: 'Medium acidity, resolved tannin, long savory finish',
    pairing: 'Lamb chop',
    acidity: 3,
    tannin: 3,
    body: 4,
    sweetness: 1,
    memo: 'Decanting helped after 40 minutes.',
  ),
];
