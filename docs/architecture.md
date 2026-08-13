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

Images are copied into the app documents directory before their paths are saved.
Database rows should not point at picker cache files because those files may be
removed by the platform.

Image lifecycle follows database ownership. Replacing or removing a photo cleans
up the previous managed file after the database write succeeds. Deleting a wine
also removes the bottle and tasting-note images it owns. If a database write
fails after a new image was imported, the new managed file is discarded.

Deleting the current 1:1 wine purchase record removes its bottle, manual price
observations, and tasting notes. This is intentionally conservative until the
app supports multiple bottles pointing at the same canonical wine.

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

Manual price observations are now a history, not a single replaceable field.
The purchase form can still hold one `Manual reference` baseline, but additional
seller prices entered from the detail screen are preserved when the purchase
record is edited. Detail-screen observations can be added, edited, or deleted
without touching the purchase record itself.

The first purchase judgement is intentionally simple:

- Compare the user's purchase price against the average of observations for the
  same wine.
- Mark the bottle as cheap when purchase price is at least 10% below average.
- Mark it as expensive when purchase price is at least 10% above average.
- Show minimum, average, and maximum prices beside the spectrum so the judgement
  remains inspectable.

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
7. Manual reference prices and price observations
8. Price alerts
9. External API adapters

Purchase and tasting dates are user-selected in the form layer and persisted as
`DateTime` values in SQLite. The UI intentionally formats them through the
shared formatter so later locale changes stay centralized.

The first search/filter pass is intentionally app-side filtering over live Drift
streams. This keeps the UI behavior simple while the local dataset is small. If
the cellar grows large, move the same `WineFilter` contract into SQL-backed
queries without changing the presentation widgets.

## Database migrations

Drift schema snapshots are stored under `drift_schemas/app_database`. The
database is registered in `build.yaml`, and its constructor accepts a custom
`QueryExecutor` so generated migration tests can open historical schemas.

For every schema change:

1. Change the table definitions and increment `schemaVersion` together.
2. Run `dart run drift_dev make-migrations`.
3. Implement each generated step in `app_database.steps.dart` and connect it to
   `MigrationStrategy.onUpgrade`.
4. Add a data-preservation test when a migration transforms or removes data.
5. Run `flutter analyze` and `flutter test` before committing the new snapshot.

Foreign-key enforcement is enabled in `MigrationStrategy.beforeOpen`. A fresh
database test validates both the generated schema and the connection pragma.
