import 'package:flutter_test/flutter_test.dart';
import 'package:miruvor/app/app.dart';

void main() {
  testWidgets('Miruvor renders the home shell', (tester) async {
    await tester.pumpWidget(const MiruvorApp());

    expect(find.text('Miruvor'), findsOneWidget);
    expect(find.text('보유 병수'), findsOneWidget);
    expect(find.text('최근 등록'), findsOneWidget);
  });

  testWidgets('Bottom navigation opens tasting notes', (tester) async {
    await tester.pumpWidget(const MiruvorApp());

    await tester.tap(find.text('Notes'));
    await tester.pump();

    expect(find.text('Tasting Notes'), findsOneWidget);
    expect(find.text('테이스팅 노트 추가'), findsOneWidget);
  });
}
