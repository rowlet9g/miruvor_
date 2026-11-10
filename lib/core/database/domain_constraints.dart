// Cross-row constraints complement foreign keys and CHECK constraints.
// Keep these stable for v2; later schema changes require versioned migrations.
final domainConstraints = <String>[
  for (final table in [
    'purchase_records',
    'bottle_records',
    'tasting_note_records',
    'price_observation_records'
  ])
    """CREATE TRIGGER IF NOT EXISTS ${table}_wine_immutable
      BEFORE UPDATE OF wine_id ON $table WHEN NEW.wine_id <> OLD.wine_id
      BEGIN SELECT RAISE(ABORT, 'wine relationship is immutable'); END""",
  for (final table in [
    'wine_records',
    'purchase_records',
    'bottle_records',
    'tasting_note_records',
    'price_observation_records'
  ])
    """CREATE TRIGGER IF NOT EXISTS ${table}_id_immutable
      BEFORE UPDATE OF id ON $table WHEN NEW.id <> OLD.id
      BEGIN SELECT RAISE(ABORT, 'record id is immutable'); END""",
  for (final operation in ['INSERT', 'UPDATE'])
    """CREATE TRIGGER IF NOT EXISTS bottle_purchase_${operation.toLowerCase()}
      BEFORE $operation ON bottle_records WHEN NEW.purchase_id IS NOT NULL
      BEGIN
        SELECT CASE WHEN NOT EXISTS (
          SELECT 1 FROM purchase_records p WHERE p.id = NEW.purchase_id
          AND p.wine_id = NEW.wine_id AND p.volume_ml IS NEW.volume_ml
          AND NEW.acquisition_kind = 'purchase'
        ) THEN RAISE(ABORT, 'bottle purchase mismatch') END;
        SELECT CASE WHEN (
          SELECT count(*) FROM bottle_records b
          WHERE b.purchase_id = NEW.purchase_id AND b.id <> NEW.id
        ) >= (SELECT purchased_quantity FROM purchase_records WHERE id = NEW.purchase_id)
        THEN RAISE(ABORT, 'purchase quantity exceeded') END;
      END""",
  """CREATE TRIGGER IF NOT EXISTS purchase_linked_bottles_update
    BEFORE UPDATE ON purchase_records BEGIN
      SELECT CASE WHEN NEW.purchased_quantity < (
        SELECT count(*) FROM bottle_records WHERE purchase_id = NEW.id
      ) THEN RAISE(ABORT, 'purchase quantity below linked bottles') END;
      SELECT CASE WHEN EXISTS (
        SELECT 1 FROM bottle_records WHERE purchase_id = NEW.id
        AND (wine_id <> NEW.wine_id OR volume_ml IS NOT NEW.volume_ml)
      ) THEN RAISE(ABORT, 'purchase volume mismatch') END;
    END""",
  for (final operation in ['INSERT', 'UPDATE'])
    """CREATE TRIGGER IF NOT EXISTS note_bottle_${operation.toLowerCase()}
      BEFORE $operation ON tasting_note_records WHEN NEW.bottle_id IS NOT NULL
      BEGIN SELECT CASE WHEN NOT EXISTS (
        SELECT 1 FROM bottle_records WHERE id = NEW.bottle_id AND wine_id = NEW.wine_id
      ) THEN RAISE(ABORT, 'note bottle wine mismatch') END; END""",
  """CREATE TRIGGER IF NOT EXISTS archive_requires_empty_stock
    BEFORE UPDATE OF is_archived ON wine_records WHEN NEW.is_archived = 1
    BEGIN SELECT CASE WHEN EXISTS (
      SELECT 1 FROM bottle_records WHERE wine_id = NEW.id AND status = 'inStock'
    ) THEN RAISE(ABORT, 'cannot archive wine with stock') END; END""",
  '''CREATE TRIGGER IF NOT EXISTS unarchive_new_bottle
    AFTER INSERT ON bottle_records
    BEGIN UPDATE wine_records SET is_archived = 0 WHERE id = NEW.wine_id; END''',
  """CREATE TRIGGER IF NOT EXISTS unarchive_returned_stock
    AFTER UPDATE OF status ON bottle_records WHEN NEW.status = 'inStock'
    BEGIN UPDATE wine_records SET is_archived = 0 WHERE id = NEW.wine_id; END""",
];
