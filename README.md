# Miruvor

Personal wine-log mobile application built with Flutter.

## MVP scope

- Record purchased wines with producer, vintage, grape varieties, purchase date,
  purchase price, shop, storage location, and photo path.
- Keep tasting notes with rating, aroma, palate, pairing, and personal memo.
- Compare purchase price against a reference price entered manually at first.
- Search and filter the local wine collection by name, producer, country, type,
  and price range.

External price/review integrations are intentionally outside the first build.
They should be added through adapters after API access, terms, and data quality
are verified.

## Project shape

```text
lib/
  app/                 App entry, theme, top-level shell
  core/
    models/            Domain models shared across features
    sample/            Temporary in-memory sample data
    utils/             Formatting and small shared helpers
  features/
    cellar/            Purchased bottle and wine detail flows
    tasting_notes/     Tasting note list and entry flows
    price_check/       Price comparison and reference price UI
    wine_search/       Search/filter UI
    shared/            Reusable presentation widgets
```

## Next build steps

1. Install or expose Flutter SDK on `PATH`.
2. Run `flutter create .` in this directory to generate platform folders.
3. Run `flutter pub get`.
4. Replace `core/sample/sample_data.dart` with a local repository backed by
   SQLite, preferably `drift`.
5. Add image picking and app-local image storage.
6. Add price-source adapters only for allowed APIs or user-entered references.
