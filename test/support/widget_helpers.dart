import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miruvor/app/app.dart';
import 'package:miruvor/core/database/app_database.dart';
import 'package:miruvor/core/store/miruvor_store.dart';

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
  await openCatalog(tester);
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

Future<void> openCellar(WidgetTester tester) async {
  await tap(
      tester,
      find
          .descendant(
              of: find.byType(NavigationBar), matching: find.text('내 셀러'))
          .last);
}

Future<void> openCatalog(WidgetTester tester) async {
  await openCellar(tester);
  await tap(tester, find.text('전체 와인 기록'));
}
