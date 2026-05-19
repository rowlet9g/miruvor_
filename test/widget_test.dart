import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miruvor/app/app.dart';
import 'package:miruvor/core/database/app_database.dart';
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

Future<void> _disposeApp(WidgetTester tester, MiruvorStore store) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 1));
  await tester.pump(const Duration(milliseconds: 1));
  store.dispose();
  await tester.pump(const Duration(milliseconds: 1));
}
