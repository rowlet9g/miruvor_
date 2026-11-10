# Miruvor Architecture Notes

## Scope and status

P0 policy and P1 implementation completed on **2026-11-10**. App version
`0.1.0+1`, database version **2**. The [project plan](project-plan.md) records
current behavior, remaining work, and verification limits; the
[domain contract](domain-policy.md) defines preservation requirements.

Miruvor is a local-first wine log. Personal records remain usable without an
account, external price provider, or AI service. No external API integration is
implemented in P1.

## Current v2 domain boundaries

| Entity | Responsibility | Connections |
|---|---|---|
| Wine | Product/cuvee and vintage identity, optional metadata/photo, wishlist/archive flags | Parent of purchases, bottles, notes, and reference prices |
| Purchase | One wine/volume bought on one occasion; original quantity and total paid KRW | Required Wine; zero or more linked Bottles after corrections/deletion |
| Bottle | One physical bottle; acquisition, volume, location/photo, current status | Required Wine; optional Purchase |
| TastingNote | Personal tasting, optional date/rating/photo/sensory fields/buy-again intent | Required Wine; optional Bottle |
| PriceObservation | Manually recorded reference price and its source/date/conditions | Required Wine; independent of Purchase |
| PendingImageDeletion | Durable queue of files awaiting safe cleanup | Path and request time; no record ownership |

A wine can exist with a name or photo and no purchase or bottle. Matching names
never merge records automatically. Vintage distinguishes a known year,
non-vintage, and unknown. Missing dates, purchase totals, and ratings stay null;
confirmed zero purchase totals remain distinct from missing totals.

A new purchase creates its original quantity of bottles atomically. Unit cost is
derived from total paid divided by original quantity. Editing purchase quantity
does not create or delete bottles; it cannot drop below the linked bottle count.
Correcting purchase volume updates linked bottles in the same transaction.
Historical totals do not change when bottles are consumed, gifted, returned, or
removed as erroneous entries.

Inventory counts only `inStock` bottles. `consumed`, `gifted`, and `returned`
retain the physical record. Archiving requires no stock; adding a bottle or
returning one to stock unarchives its wine. Event dates are independent of
database creation/update timestamps and are never inferred from those timestamps.

The note UI supports wine-only notes and nullable rating/date. The store also
supports repeated notes for one bottle and atomic note-plus-consumption writes.
Bottle selection and the combined consumption form remain P3 work. Sensory and
buy-again fields are persisted and preserved on edits, but their input UI remains
P2 work.

## Persistence and constraints

The schema is split into [table definitions](../lib/core/database/domain_tables.dart),
[queries and mappings](../lib/core/database/app_database.dart),
[relationship triggers](../lib/core/database/domain_constraints.dart), and
[versioned migration](../lib/core/database/domain_migration.dart).

- Required Wine foreign keys use RESTRICT; optional Purchase/Bottle references
  use SET NULL on parent deletion.
- CHECK constraints enforce enum values, quantities, monetary/sensory ranges,
  and minimum wine/note content.
- SQL triggers reject cross-wine links, mismatched purchase volume/acquisition,
  capacity overflow, and changes to record IDs or child Wine IDs. Archive and
  restock rules also run at the database boundary.
- Six indexes cover child Wine IDs, bottle Purchase ID, and note Bottle ID.
- `MiruvorStore` serializes application writes. Each write is a transaction;
  post-commit file cleanup runs before the next queued write.
- Catalog reads produce one Wine entry containing all purchases and bottles.
  The live query observes all three tables and reads a transactional snapshot.
  Filtering is currently app-side for a small local dataset.

The catalog displays the latest purchase unit price; a price-range filter matches
any known historical purchase unit price. Unknown prices do not match a numeric
price filter. Home inventory cost sums known unit costs of in-stock bottles and
shows how many remaining bottles have unknown cost. Recent registration is
ordered by Wine creation time.

## Deletion and photo lifetime

| Operation | Preserved data |
|---|---|
| Delete Purchase | Wine, all Bottles, Notes and reference prices; bottles lose only purchaseId |
| Delete Bottle | Wine, Purchase original totals, Notes and prices; notes lose only bottleId |
| Delete TastingNote | Wine, Bottle state and all other records |
| Archive Wine | All records and photos |
| Erase Wine permanently | Other wines and photos still referenced by any surviving record |

Full erasure is an explicit detail-screen action with counts of affected
purchases, bottles, notes, reference prices, and unshared photos. The store
rechecks an impact signature before deletion so a changed set of records requires
a new preview. Child rows are removed explicitly in one transaction.

Photos are copied into the app documents directory before storing their paths.
After a successful record change, candidate paths enter the persistent cleanup
queue. Cleanup checks Wine, Bottle and TastingNote references together, normalizes
paths, and deletes only managed files with no live references. Failed filesystem
operations leave the queue entry for retry on the next write/startup. A failed
database write leaves prior references intact; forms discard only newly imported
copies. The discard operation also rechecks references, protecting a path already
used by another record.

Migration never moves or deletes photos. The migration recovery copy contains
database rows and their paths; it is not a portable photo-inclusive backup.

## Reference prices

Reference-price CRUD is independent of purchases. Editing a purchase does not
replace the migrated `Manual reference` or any other observation.

`PriceAnalysis` excludes legacy zero observations and produces no purchase
judgement when purchase cost is unknown. For positive reference prices, it still
uses a simple average with ±10% thresholds, plus minimum/maximum display. The
detail screen flags retained zero observations for correction.

Observation date and stock controls are not exposed in the current form. Volume
exists in the data model but is not yet an eligibility filter; age, stock,
currency, shipping, discounts, and source duplication are also unresolved P4
work. One positive observation can still produce a judgement.

<a id="planned-domain-policy-p0-complete"></a>

## Policy implementation and deferred decisions

P1 implements the storage and preservation portions of the
[P0 contract](domain-policy.md), including examples E-01 through E-17 at the
database/store boundary. Minimal forms make separate wine/purchase/bottle editing
and deletion usable now.

P2 still owns capture-flow simplification, menu/search consolidation, sensory and
buy-again input, and measured capture time. P3 owns the combined bottle/tasting
flow. Opening state, remaining volume, complete status history, wine merging,
refund accounting, trash, price evidence thresholds, and backup conflicts remain
deferred under the domain contract. P5 owns user-facing export/restore and device
verification.

## Database migrations

Snapshots live in `drift_schemas/app_database`; current version is 2 and version
1 remains unchanged. `app_database.steps.dart` contains generated frozen schema
types. The handwritten v1 converter uses `Schema2`, avoiding a dependency on
future current-table definitions.

For a file-backed v1 database, opening performs:

1. Create a consistent sibling recovery file named
   `<database>.v1-backup-<timestamp>.sqlite` with SQLite `VACUUM INTO`.
   This includes committed WAL contents; it does not copy just the main DB file.
2. Disable foreign keys outside the migration transaction and validate existing
   references, matching wine links, monetary/sensory values, and grape JSON.
3. In one transaction, run the versioned migration steps, preserve existing IDs,
   map each old bottle to `legacy-purchase:<bottleId>` with quantity 1, check all
   foreign keys, and install relationship triggers.
4. Commit schema, rows and user_version together, then enable foreign keys.
   A failure rolls back the conversion and reports the cause/recovery path.

Old null vintage becomes unknown, not NV. Purchase date/price/shop and original
creation/update times move from Bottle to Purchase. Actual acquisition/consumption
dates are left unknown. Note/photo/price fields stay intact, including legacy
zero reference prices; newly introduced PriceObservation.updatedAt stays null.

The use of explicit transactions and foreign-key handling follows the
[Drift migration guidance](https://drift.simonbinder.eu/migrations/)
and [step-by-step migration API](https://drift.simonbinder.eu/migrations/step_by_step/).

For subsequent schema changes:

1. Increment `schemaVersion` with the table definitions.
2. Run `dart run build_runner build` and `dart run drift_dev make-migrations`.
3. Implement the new versioned converter in the handwritten migration file;
   do not hand-edit generated snapshots/steps or rewrite historical JSON.
4. Add populated historical-database preservation and failure tests.
5. Run analysis and the complete test suite before committing.

Current validation: **42 passing tests** and clean static analysis on Windows.
Coverage includes populated WAL v1 migration, recovery-copy readability, mid-step
rollback, invalid legacy data rejection, v2 close/reopen, durable photo cleanup,
foreign-key/trigger constraints, and widget flows. This does not validate mobile
permissions, real-device upgrades, release builds, or user backup restoration.
A dedicated migration-recovery UI is not yet present.

## Optional external integrations

`PriceRepository`, `ManualPriceSource`, `WineSearcherPriceSource`, and
`RetailerPriceSource` are future adapter concepts, not implemented classes.
External provider payloads should stay separate from personal record identity.

AI capture is also a proposal: a selected label photo or memo produces an
unconfirmed draft through a server-side call, then the user reviews values before
the existing local save path. Keys stay on the server; AI never chooses database
IDs, merges records, or invents market prices. See
[API integration options](api-integration-options.md). P1 introduces no API calls,
server, credentials, account changes, or expenditure.
