# Miruvor Architecture Notes

## Current decision

Miruvor starts as a local-first wine log. The first version should not depend on
Wine-Searcher, Vivino, Wine21, Dailyshot, or retailer pages to be useful.

The core reason is data reliability. Price and review integrations have API,
terms-of-use, matching, vintage, volume, inventory, and crawling stability
constraints. The app should keep personal records independently and treat
external data as optional enrichment.

## Domain boundaries

### Wine

Canonical wine identity.

- Name
- Producer
- Country and region
- Vintage
- Type
- Grape varieties

### Bottle

User-owned purchase instance.

- Wine reference
- Purchase date
- Purchase price
- Shop
- Photo path
- Storage location
- Consumed state

### TastingNote

User's own drinking record.

- Wine and optional bottle reference
- Tasting date
- Rating
- Aroma and palate
- Pairing
- Acidity, tannin, body, sweetness
- Photo path
- Memo

### PriceObservation

Point-in-time reference price.

- Wine reference
- Source name
- Price
- Observation date
- URL
- Stock state
- Note

## Data-source strategy

Price and review providers should be hidden behind adapters. A future adapter can
read from an official API, a manually entered URL, or a partner data feed without
changing the UI or domain models.

```text
PriceCheck feature
  -> PriceRepository
    -> ManualPriceSource
    -> WineSearcherPriceSource
    -> RetailerPriceSource
```

Do not put crawler-specific fields into `Wine`, `Bottle`, or `TastingNote`.
Store source-specific fields inside adapter DTOs or metadata tables.

## Recommended implementation order

1. Flutter platform scaffold
2. Local SQLite schema
3. Add/edit/delete wine purchase records
4. Add/edit/delete tasting notes
5. Image picker and local file storage
6. Search and filters
7. Manual reference prices
8. Price alerts
9. External API adapters
