import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miruvor/app/app.dart';
import 'package:miruvor/core/database/app_database.dart';
import 'package:miruvor/core/models/bottle.dart';
import 'package:miruvor/core/models/wine_type.dart';
import 'package:miruvor/core/store/miruvor_store.dart';

void main() {
  testWidgets('Miruvor renders the home shell', (tester) async {
    final store = await pumpApp(tester);
    expect(find.text('Miruvor'), findsOneWidget);
    expect(find.text('보유 병수'), findsOneWidget);
    expect(find.text('최근 등록'), findsOneWidget);
    await disposeApp(tester, store);
  });

  testWidgets('Bottom navigation opens tasting notes', (tester) async {
    final store = await pumpApp(tester);
    await tap(tester, find.text('Notes'));
    expect(find.text('Tasting Notes'), findsOneWidget);
    expect(find.text('테이스팅 노트 추가'), findsOneWidget);
    await disposeApp(tester, store);
  });

  testWidgets(
      'Wine registration creates no purchase; purchases and repurchases reuse it',
      (tester) async {
    final store = await pumpApp(tester);
    await tap(tester, find.byIcon(Icons.add));
    await enter(tester, '이름', 'Test Wine');
    await tap(tester, find.widgetWithText(FilledButton, '저장'));
    expect(await store.database.select(store.database.purchaseRecords).get(),
        isEmpty);
    expect(await store.database.select(store.database.bottleRecords).get(),
        isEmpty);
    final wine = (await store.database.catalogSnapshot()).single.wine;
    expect(wine.producer, isNull);
    await tap(tester, find.text('Cellar'));
    await tap(tester, find.textContaining('Test Wine'));
    await tap(tester, find.text('구매 추가'));
    await enter(tester, '구매 수량', '3');
    await enter(tester, '구매 총액', '126000');
    await tap(tester, find.widgetWithText(FilledButton, '저장'));
    var entry = (await store.entryForWine(wine.id))!;
    expect(entry.stockCount, 3);
    expect(entry.purchases.single.unitPrice, 42000);
    expect(entry.purchases.single.purchaseDate, isNull);
    await tap(tester, find.text('구매 추가'));
    await enter(tester, '구매 수량', '2');
    await enter(tester, '구매 총액', '80000');
    await tap(tester, find.widgetWithText(FilledButton, '저장'));
    entry = (await store.entryForWine(wine.id))!;
    expect(entry.stockCount, 5);
    expect(entry.purchases, hasLength(2));
    expect(await store.database.select(store.database.wineRecords).get(),
        hasLength(1));
    await disposeApp(tester, store);
  });

  testWidgets('Cellar filters by query and known purchase unit price',
      (tester) async {
    final store = await pumpApp(tester);
    await store.addWinePurchase(
        name: 'Left Bank Blend',
        producer: 'Chateau',
        country: 'France',
        type: WineType.red,
        purchasePrice: 84000,
        purchasedQuantity: 2);
    await store.addWinePurchase(
        name: 'Riesling Trocken',
        country: 'Germany',
        type: WineType.white,
        purchasePrice: 82000);
    await store.createWine(name: 'Unknown Price');
    await tester.pumpAndSettle();
    await tap(tester, find.text('Cellar'));
    await enterFilter(tester, hint: '이름, 생산자, 국가 검색', value: 'Riesling');
    expect(find.textContaining('Left Bank Blend'), findsNothing);
    expect(find.textContaining('Riesling Trocken'), findsOneWidget);
    await tap(tester, find.byTooltip('필터 초기화'));
    await enterFilter(tester, label: '최대 가격', value: '50000');
    expect(find.textContaining('Left Bank Blend'), findsOneWidget);
    expect(find.textContaining('Riesling Trocken'), findsNothing);
    expect(find.textContaining('Unknown Price'), findsNothing);
    await disposeApp(tester, store);
  });

  testWidgets(
      'Wine and purchase edit separately; whole-wine erase previews its impact',
      (tester) async {
    final store = await pumpApp(tester);
    final id = await store.addWinePurchase(
        name: 'Original Wine',
        purchasePrice: 42000,
        purchaseDate: DateTime(2026, 5, 1),
        referencePrice: 50000);
    await tester.pumpAndSettle();
    await openDetail(tester, 'Original Wine');
    await tap(tester, find.byTooltip('와인 정보 수정'));
    await enter(tester, '이름', 'Edited Wine');
    await tap(tester, find.widgetWithText(FilledButton, '수정 저장'));
    await tap(tester, find.byTooltip('구매 수정'));
    await enter(tester, '구매 총액', '55000');
    await pickDate(tester, '구매일', '3');
    await tap(tester, find.widgetWithText(FilledButton, '수정 저장'));
    final purchase = (await store.entryForWine(id))!.purchases.single;
    expect(purchase.totalPaidKrw, 55000);
    expect(purchase.purchaseDate, DateTime(2026, 5, 3));
    expect((await store.findWine(id))!.name, 'Edited Wine');
    expect(
        await store.database
            .select(store.database.priceObservationRecords)
            .get(),
        hasLength(1));
    await tap(tester, find.byTooltip('와인 전체 영구 삭제'));
    expect(find.textContaining('구매 1건, 병 1개, 시음 노트 0건'), findsOneWidget);
    await tap(tester, find.widgetWithText(FilledButton, '삭제'));
    expect(await store.findWine(id), isNull);
    expect(find.text('아직 등록된 와인이 없습니다.'), findsOneWidget);
    await disposeApp(tester, store);
  });

  testWidgets(
      'Price observations can be added, edited, and removed independently',
      (tester) async {
    final store = await pumpApp(tester);
    await store.addWinePurchase(
        name: 'Market Check Wine', purchasePrice: 40000);
    await tester.pumpAndSettle();
    await openDetail(tester, 'Market Check Wine');
    await tap(tester, find.text('가격 추가'));
    await enter(tester, '판매처', 'Dailyshot');
    await enter(tester, '판매 가격', '50000');
    await enter(tester, '메모', 'Weekend deal');
    await tap(tester, find.widgetWithText(FilledButton, '저장'));
    await reveal(tester, find.text('싸게 삼'));
    expect(find.text('싸게 삼'), findsOneWidget);
    await tap(tester, find.byTooltip('가격 수정'));
    await enter(tester, '판매처', 'Wine25');
    await enter(tester, '판매 가격', '30000');
    await tap(tester, find.widgetWithText(FilledButton, '수정 저장'));
    await reveal(tester, find.text('비싸게 삼'));
    expect(find.text('Wine25'), findsOneWidget);
    await tap(tester, find.byTooltip('가격 삭제'));
    expect(
        await store.database
            .select(store.database.priceObservationRecords)
            .get(),
        isEmpty);
    expect(find.text('아직 가격 관측치가 없습니다. 판매처 가격을 추가해 보세요.'), findsOneWidget);
    await disposeApp(tester, store);
  });

  testWidgets('Tasting note can be edited and deleted while retaining the wine',
      (tester) async {
    final store = await pumpApp(tester);
    final id = await store.createWine(name: 'Note Wine');
    await store.addTastingNote(
        wineId: id,
        tastedAt: DateTime(2026, 5, 2),
        rating: 4,
        pairing: 'Pasta',
        acidity: 3,
        body: 4);
    await tester.pumpAndSettle();
    await tap(tester, find.text('Notes'));
    await tap(tester, find.byTooltip('노트 작업'));
    await tap(tester, find.text('수정'));
    await enter(tester, '평점', '3.5');
    await pickDate(tester, '시음일', '4');
    await enter(tester, '페어링 음식', 'Steak');
    await tap(tester, find.widgetWithText(FilledButton, '수정 저장'));
    expect(find.textContaining('3.5 / 5.0'), findsOneWidget);
    expect(find.textContaining('2026.05.04'), findsOneWidget);
    expect(find.text('Pairing: Steak'), findsOneWidget);
    final note = (await store.notesForWine(id)).single;
    expect(note.acidity, 3);
    expect(note.body, 4);
    await tap(tester, find.byTooltip('노트 작업'));
    await tap(tester, find.text('삭제'));
    await tap(tester, find.widgetWithText(FilledButton, '삭제'));
    expect(await store.notesForWine(id), isEmpty);
    expect(await store.findWine(id), isNotNull);
    await disposeApp(tester, store);
  });

  testWidgets(
      'Wine-only tasting saves without fabricated rating, date, purchase or bottle',
      (tester) async {
    final store = await pumpApp(tester);
    final id = await store.createWine(name: 'One glass');
    await tester.pumpAndSettle();
    await openDetail(tester, 'One glass');
    await tap(tester, find.text('시음 추가'));
    await enter(tester, '메모', 'Fresh and lovely');
    await tap(tester, find.widgetWithText(FilledButton, '저장'));
    final note = (await store.notesForWine(id)).single;
    expect(note.rating, isNull);
    expect(note.tastedAt, isNull);
    expect(note.bottleId, isNull);
    expect(note.memo, 'Fresh and lovely');
    expect((await store.entryForWine(id))!.purchases, isEmpty);
    expect((await store.entryForWine(id))!.bottles, isEmpty);
    await disposeApp(tester, store);
  });

  testWidgets(
      'Deleting purchase and bottle via UI preserves the tasting and price',
      (tester) async {
    final store = await pumpApp(tester);
    final id = await store.addWinePurchase(
        name: 'Preserve',
        purchasedQuantity: 3,
        purchasePrice: 90000,
        referencePrice: 35000);
    final bottle = (await store.entryForWine(id))!.bottles.first;
    final note = await store.addTastingNote(
        wineId: id, bottleId: bottle.id, memo: 'Keep this note');
    await tester.pumpAndSettle();
    await openDetail(tester, 'Preserve');
    await tap(tester, find.byTooltip('구매 삭제'));
    expect(find.textContaining('병과 보유 수량, 시음 노트, 참고 가격은 유지'), findsOneWidget);
    await tap(tester, find.widgetWithText(FilledButton, '삭제'));
    var entry = (await store.entryForWine(id))!;
    expect(entry.stockCount, 3);
    expect(entry.purchases, isEmpty);
    expect((await store.findTastingNote(note))!.bottleId, bottle.id);
    await tap(tester, find.text('병 기록 3개'));
    await tap(tester, find.byTooltip('병 기록 삭제').first);
    await tap(tester, find.widgetWithText(FilledButton, '삭제'));
    entry = (await store.entryForWine(id))!;
    expect(entry.stockCount, 2);
    expect((await store.findTastingNote(note))!.bottleId, isNull);
    expect(
        await store.database
            .select(store.database.priceObservationRecords)
            .get(),
        hasLength(1));
    await disposeApp(tester, store);
  });

  testWidgets('Consumed checkbox on a new purchase is persisted',
      (tester) async {
    final store = await pumpApp(tester);
    final id = await store.createWine(name: 'Already enjoyed');
    await tester.pumpAndSettle();
    await openDetail(tester, 'Already enjoyed');
    await tap(tester, find.text('구매 추가'));
    await tap(tester, find.text('마신 병으로 표시'));
    await tap(tester, find.widgetWithText(FilledButton, '저장'));
    final entry = (await store.entryForWine(id))!;
    expect(entry.bottles.single.status, BottleStatus.consumed);
    expect(entry.bottles.single.statusChangedAt, isNull);
    expect(entry.stockCount, 0);
    expect(entry.purchases.single.totalPaidKrw, isNull);
    await disposeApp(tester, store);
  });

  testWidgets('Gift bottle registration and status editing need no purchase',
      (tester) async {
    final store = await pumpApp(tester);
    final id = await store.createWine(name: 'Gift');
    await tester.pumpAndSettle();
    await openDetail(tester, 'Gift');
    await tap(tester, find.text('구매 없이 병 추가'));
    await enter(tester, '병 용량 (mL)', '750');
    await enter(tester, '보관 위치', 'Shelf B');
    await tap(tester, find.widgetWithText(FilledButton, '저장'));
    var entry = (await store.entryForWine(id))!;
    expect(entry.purchases, isEmpty);
    expect(entry.bottles.single.acquisitionKind, AcquisitionKind.gift);
    expect(entry.bottles.single.volumeMl, 750);
    await tap(tester, find.text('병 기록 1개'));
    await tap(tester, find.byTooltip('병 수정'));
    await tap(tester, find.byType(DropdownButtonFormField<BottleStatus>));
    await tap(tester, find.text('소비').last);
    await tap(tester, find.widgetWithText(FilledButton, '수정 저장'));
    entry = (await store.entryForWine(id))!;
    expect(entry.stockCount, 0);
    expect(entry.bottles.single.storageLocation, 'Shelf B');
    expect(entry.purchases, isEmpty);
    await disposeApp(tester, store);
  });
}

Future<MiruvorStore> pumpApp(WidgetTester tester) async {
  final store = MiruvorStore(database: AppDatabase.inMemory());
  await tester.pumpWidget(MiruvorApp(store: store));
  await tester.pumpAndSettle();
  return store;
}

Future<void> reveal(WidgetTester tester, Finder finder) async {
  if (finder.evaluate().isEmpty) {
    await tester.drag(pageScroll(), const Offset(0, 3000));
    await tester.pumpAndSettle();
  }
  for (var i = 0; i < 20 && finder.evaluate().isEmpty; i++) {
    await tester.drag(pageScroll(), const Offset(0, -240));
    await tester.pumpAndSettle();
  }
  expect(finder, findsOneWidget);
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
}

Future<void> tap(WidgetTester tester, Finder finder) async {
  await reveal(tester, finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

// Multiline text fields have their own Scrollable; move the form, not its text.
Finder pageScroll() => find
    .byWidgetPredicate(
        (widget) => widget is Scrollable && widget.restorationId != 'editable')
    .last;
Future<void> enter(WidgetTester tester, String label, String value) async {
  final finder = find.widgetWithText(TextFormField, label);
  await reveal(tester, finder);
  await tester.enterText(finder, value);
  await tester.pumpAndSettle();
}

Future<void> enterFilter(WidgetTester tester,
    {String? hint, String? label, required String value}) async {
  final finder = find.byWidgetPredicate((w) =>
      w is TextField &&
      w.decoration?.hintText == hint &&
      w.decoration?.labelText == label);
  await reveal(tester, finder);
  await tester.enterText(finder, value);
  await tester.pumpAndSettle();
}

Future<void> openDetail(WidgetTester tester, String name) async {
  await tap(tester, find.text('Cellar'));
  await tap(tester, find.textContaining(name));
}

Future<void> pickDate(WidgetTester tester, String label, String day) async {
  await reveal(tester, find.text(label));
  await tester.tap(find
      .ancestor(of: find.text(label), matching: find.byType(InkWell))
      .first);
  await tester.pumpAndSettle();
  await tester.tap(find.text(day).last);
  await tester.tap(find.text('OK'));
  await tester.pumpAndSettle();
}

Future<void> disposeApp(WidgetTester tester, MiruvorStore store) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pumpAndSettle();
  await store.close();
  store.dispose();
}
