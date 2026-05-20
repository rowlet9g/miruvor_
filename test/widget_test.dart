import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miruvor/app/app.dart';
import 'package:miruvor/core/database/app_database.dart';
import 'package:miruvor/core/models/wine_type.dart';
import 'package:miruvor/core/store/miruvor_store.dart';

void main() {
  testWidgets('Miruvor renders the home shell', (tester) async {
    final store = await _pumpApp(tester);

    expect(find.text('Miruvor'), findsOneWidget);
    expect(find.text('보유 병수'), findsOneWidget);
    expect(find.text('최근 등록'), findsOneWidget);

    await _disposeApp(tester, store);
  });

  testWidgets('Bottom navigation opens tasting notes', (tester) async {
    final store = await _pumpApp(tester);

    await tester.tap(find.text('Notes'));
    await tester.pump();

    expect(find.text('Tasting Notes'), findsOneWidget);
    expect(find.text('테이스팅 노트 추가'), findsOneWidget);

    await _disposeApp(tester, store);
  });

  testWidgets('Add wine saves a purchase into the cellar', (tester) async {
    final store = await _pumpApp(tester);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await _enterTextByLabel(tester, '이름', 'Test Wine');
    await _enterTextByLabel(tester, '생산자', 'Test Producer');
    await _enterTextByLabel(tester, '국가', 'France');
    await _enterTextByLabel(tester, '빈티지', '2020');
    await _enterTextByLabel(tester, '포도 품종', 'Merlot');
    await _enterTextByLabel(tester, '구매 가격', '42000');
    await _enterTextByLabel(tester, '수동 기준가', '50000');

    await tester.tap(find.text('저장'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Test Wine'), findsWidgets);

    await tester.tap(find.text('Cellar'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Test Wine'), findsOneWidget);
    expect(find.text('KRW 42,000'), findsOneWidget);

    await _disposeApp(tester, store);
  });

  testWidgets('Cellar filters by query and price', (tester) async {
    final store = await _pumpApp(tester);

    await store.addWinePurchase(
      name: 'Left Bank Blend',
      producer: 'Test Chateau',
      country: 'France',
      type: WineType.red,
      purchaseDate: DateTime(2026, 5, 1),
      purchasePrice: 42000,
      grapeVarieties: const ['Cabernet Sauvignon'],
    );
    await store.addWinePurchase(
      name: 'Riesling Trocken',
      producer: 'Test Weingut',
      country: 'Germany',
      type: WineType.white,
      purchaseDate: DateTime(2026, 5, 2),
      purchasePrice: 82000,
      grapeVarieties: const ['Riesling'],
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cellar'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Left Bank Blend'), findsOneWidget);
    expect(find.textContaining('Riesling Trocken'), findsOneWidget);

    await _enterTextField(tester,
        hintText: '이름, 생산자, 국가 검색', value: 'Riesling');

    expect(find.textContaining('Left Bank Blend'), findsNothing);
    expect(find.textContaining('Riesling Trocken'), findsOneWidget);

    await tester.tap(find.byTooltip('필터 초기화'));
    await tester.pumpAndSettle();
    await _enterTextField(tester, labelText: '최대 가격', value: '50000');

    expect(find.textContaining('Left Bank Blend'), findsOneWidget);
    expect(find.textContaining('Riesling Trocken'), findsNothing);

    await _disposeApp(tester, store);
  });

  testWidgets('Wine purchase can be edited and deleted', (tester) async {
    final store = await _pumpApp(tester);

    await store.addWinePurchase(
      name: 'Original Wine',
      producer: 'Original Producer',
      country: 'France',
      type: WineType.red,
      purchaseDate: DateTime(2026, 5, 1),
      purchasePrice: 42000,
      referencePrice: 50000,
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cellar'));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Original Wine'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('수정'));
    await tester.pumpAndSettle();
    await _enterTextByLabel(tester, '이름', 'Edited Wine');
    await _enterTextByLabel(tester, '구매 가격', '55000');
    await _pickDate(tester, fieldLabel: '구매일', day: '3');
    await tester.tap(find.text('수정 저장'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Edited Wine'), findsOneWidget);
    expect(find.textContaining('Original Wine'), findsNothing);
    expect(find.text('KRW 55,000'), findsOneWidget);

    await tester.tap(find.textContaining('Edited Wine'));
    await tester.pumpAndSettle();
    expect(find.text('2026.05.03'), findsOneWidget);

    await tester.tap(find.byTooltip('삭제'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '삭제'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Edited Wine'), findsNothing);
    expect(find.text('아직 등록된 와인이 없습니다.'), findsOneWidget);

    await _disposeApp(tester, store);
  });

  testWidgets('Price observations can be added, edited, and removed',
      (tester) async {
    final store = await _pumpApp(tester);

    await store.addWinePurchase(
      name: 'Market Check Wine',
      producer: 'Market Producer',
      country: 'Spain',
      type: WineType.red,
      purchaseDate: DateTime(2026, 5, 1),
      purchasePrice: 40000,
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cellar'));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Market Check Wine'));
    await tester.pumpAndSettle();

    expect(find.text('아직 가격 관측치가 없습니다. 판매처 가격을 추가해 보세요.'), findsOneWidget);

    await tester.tap(find.text('가격 추가'));
    await tester.pumpAndSettle();
    await _enterTextByLabel(tester, '판매처', 'Dailyshot');
    await _enterTextByLabel(tester, '판매 가격', '50000');
    await _enterTextByLabel(tester, '메모', 'Weekend deal');
    await tester.tap(find.widgetWithText(FilledButton, '저장'));
    await tester.pumpAndSettle();

    expect(find.text('싸게 삼'), findsOneWidget);
    expect(find.text('Dailyshot'), findsOneWidget);
    expect(find.text('KRW 50,000'), findsWidgets);

    final editPriceButton = find.byTooltip('가격 수정');
    await tester.ensureVisible(editPriceButton);
    await tester.pumpAndSettle();
    await tester.tap(editPriceButton);
    await tester.pumpAndSettle();
    await _enterTextByLabel(tester, '판매처', 'Wine25');
    await _enterTextByLabel(tester, '판매 가격', '30000');
    await _enterTextByLabel(tester, '메모', 'Clearance');
    await tester.tap(find.widgetWithText(FilledButton, '수정 저장'));
    await tester.pumpAndSettle();

    expect(find.text('Dailyshot'), findsNothing);
    expect(find.text('Wine25'), findsOneWidget);
    expect(find.text('비싸게 삼'), findsOneWidget);
    expect(find.text('KRW 30,000'), findsWidgets);

    final deletePriceButton = find.byTooltip('가격 삭제');
    await tester.ensureVisible(deletePriceButton);
    await tester.pumpAndSettle();
    await tester.tap(deletePriceButton);
    await tester.pumpAndSettle();

    expect(find.text('Dailyshot'), findsNothing);
    expect(find.text('아직 가격 관측치가 없습니다. 판매처 가격을 추가해 보세요.'), findsOneWidget);

    await _disposeApp(tester, store);
  });

  testWidgets('Tasting note can be edited and deleted', (tester) async {
    final store = await _pumpApp(tester);

    await store.addWinePurchase(
      name: 'Note Wine',
      producer: 'Note Producer',
      country: 'Italy',
      type: WineType.red,
      purchaseDate: DateTime(2026, 5, 1),
      purchasePrice: 39000,
    );
    final wine = (await store.database.watchCellarSnapshotOnce()).single.wine;
    await store.addTastingNote(
      wineId: wine.id,
      tastedAt: DateTime(2026, 5, 2),
      rating: 4.0,
      pairing: 'Pasta',
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Notes'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('노트 작업'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('수정'));
    await tester.pumpAndSettle();

    await _enterTextByLabel(tester, '평점', '3.5');
    await _pickDate(tester, fieldLabel: '시음일', day: '4');
    await _enterTextByLabel(tester, '페어링 음식', 'Steak');
    await tester.tap(find.text('수정 저장'));
    await tester.pumpAndSettle();

    expect(find.textContaining('3.5 / 5.0'), findsOneWidget);
    expect(find.textContaining('2026.05.04'), findsOneWidget);
    expect(find.text('Pairing: Steak'), findsOneWidget);

    await tester.tap(find.byTooltip('노트 작업'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('삭제'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '삭제'));
    await tester.pumpAndSettle();

    expect(find.textContaining('3.5 / 5.0'), findsNothing);
    expect(find.text('테이스팅 노트 추가'), findsOneWidget);

    await _disposeApp(tester, store);
  });
}

Future<MiruvorStore> _pumpApp(WidgetTester tester) async {
  final store = MiruvorStore(database: AppDatabase.inMemory());
  await tester.pumpWidget(MiruvorApp(store: store));
  await tester.pump();
  return store;
}

Future<void> _enterTextByLabel(
  WidgetTester tester,
  String label,
  String value,
) async {
  final finder = find.widgetWithText(TextFormField, label);
  for (var attempts = 0;
      attempts < 8 && finder.evaluate().isEmpty;
      attempts++) {
    await tester.drag(find.byType(Scrollable).last, const Offset(0, -260));
    await tester.pumpAndSettle();
  }
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.enterText(finder, value);
  await tester.pumpAndSettle();
}

Future<void> _enterTextField(
  WidgetTester tester, {
  String? hintText,
  String? labelText,
  required String value,
}) async {
  final finder = find.byWidgetPredicate((widget) {
    return widget is TextField &&
        widget.decoration?.hintText == hintText &&
        widget.decoration?.labelText == labelText;
  });
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.enterText(finder, value);
  await tester.pumpAndSettle();
}

Future<void> _pickDate(
  WidgetTester tester, {
  required String fieldLabel,
  required String day,
}) async {
  final labelFinder = find.text(fieldLabel);
  for (var attempts = 0;
      attempts < 8 && labelFinder.evaluate().isEmpty;
      attempts++) {
    await tester.drag(find.byType(Scrollable).last, const Offset(0, -260));
    await tester.pumpAndSettle();
  }
  await tester.ensureVisible(labelFinder);
  await tester.pumpAndSettle();
  final fieldFinder = find.ancestor(
    of: labelFinder,
    matching: find.byType(InkWell),
  );
  await tester.tap(fieldFinder, warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.tap(find.text(day).last);
  await tester.pumpAndSettle();
  await tester.tap(find.text('OK'));
  await tester.pumpAndSettle();
}

Future<void> _disposeApp(WidgetTester tester, MiruvorStore store) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 1));
  await tester.pump(const Duration(milliseconds: 1));
  store.dispose();
  await tester.pump(const Duration(milliseconds: 1));
}
