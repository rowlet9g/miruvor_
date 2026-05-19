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
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.enterText(finder, value);
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

Future<void> _disposeApp(WidgetTester tester, MiruvorStore store) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 1));
  await tester.pump(const Duration(milliseconds: 1));
  store.dispose();
  await tester.pump(const Duration(milliseconds: 1));
}
