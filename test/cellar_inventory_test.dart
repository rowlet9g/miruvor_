import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miruvor/core/models/bottle.dart';

import 'support/widget_helpers.dart';

void main() {
  testWidgets(
      'Stock entry remains scrollable with large text and an open keyboard',
      (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 740);
    tester.platformDispatcher.textScaleFactorTestValue = 1.6;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
      tester.view.resetViewInsets();
      tester.platformDispatcher.clearTextScaleFactorTestValue();
    });
    final store = await pumpApp(tester);
    await store.createWine(name: 'A label to find');
    await tester.pumpAndSettle();
    await openCellar(tester);
    await tap(tester, find.widgetWithText(FilledButton, '보유 와인 추가'));
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await enter(tester, '기존 와인 검색', 'A label');
    await tap(tester, find.textContaining('A label to find'));
    expect(find.text('구매 추가'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await disposeApp(tester, store);
  });

  testWidgets(
      'Cellar groups only in-stock bottles and values their actual purchases',
      (tester) async {
    final store = await pumpApp(tester);
    final wineId = await store.addWinePurchase(
        name: 'Cellar Red',
        purchasedQuantity: 3,
        purchasePrice: 90000,
        storageLocation: '냉장고 상단');
    final first = (await store.entryForWine(wineId))!.bottles.first;
    await store.setBottleStatus(first.id, BottleStatus.consumed);
    await store.addPurchase(
        wineId: wineId,
        purchasedQuantity: 1,
        totalPaidKrw: 40000,
        storageLocation: '거실 선반');
    final giftId = await store.createWine(name: 'Gift White');
    await store.addBottle(
        wineId: giftId, acquisitionKind: AcquisitionKind.gift);
    final tastedId = await store.createWine(name: 'Tasted at a restaurant');
    await store.addTastingNote(wineId: tastedId, memo: 'Only a glass');
    await store.createWine(name: 'Wishlist only', isWishlisted: true);
    for (final status in [
      BottleStatus.consumed,
      BottleStatus.gifted,
      BottleStatus.returned
    ]) {
      final id = await store.createWine(name: 'Past ${status.name}');
      await store.addBottle(wineId: id, status: status);
    }
    await tester.pumpAndSettle();
    await openCellar(tester);
    expect(find.text('보유 중 4병 · 2종'), findsOneWidget);
    expect(find.text('보유 병 구매 원가 KRW 100,000'), findsOneWidget);
    expect(find.text('가격 미상 1병 제외'), findsOneWidget);
    await reveal(tester, find.textContaining('Cellar Red'));
    expect(find.textContaining('Cellar Red'), findsOneWidget);
    expect(find.textContaining('3병 ·'), findsOneWidget);
    expect(find.textContaining('Tasted at a restaurant'), findsNothing);
    expect(find.textContaining('Wishlist only'), findsNothing);
    expect(find.textContaining('Past '), findsNothing);
    await tap(tester, find.textContaining('Cellar Red'));
    await reveal(tester, find.textContaining('병당 KRW 40,000').first);
    await disposeApp(tester, store);
  });

  testWidgets('Location and acquisition filters recalculate bottles and cost',
      (tester) async {
    final store = await pumpApp(tester);
    final wineId = await store.addWinePurchase(
        name: 'Red',
        purchasedQuantity: 2,
        purchasePrice: 60000,
        storageLocation: 'Upper rack');
    await store.addPurchase(
        wineId: wineId,
        purchasedQuantity: 1,
        totalPaidKrw: 50000,
        storageLocation: 'Lower rack');
    await store.addBottle(
        wineId: wineId,
        acquisitionKind: AcquisitionKind.gift,
        storageLocation: 'Upper rack');
    await tester.pumpAndSettle();
    await openCellar(tester);
    await enter(tester, '와인·생산자·보관 위치 검색', 'Upper');
    expect(find.text('표시 중 3병 · 1종'), findsOneWidget);
    expect(find.text('보유 병 구매 원가 KRW 60,000'), findsOneWidget);
    await tap(tester, find.text('구매한 병만 보기'));
    expect(find.text('표시 중 2병 · 1종'), findsOneWidget);
    expect(find.text('가격 미상 1병 제외'), findsNothing);
    await tap(tester, find.text('조건 초기화'));
    await tap(tester, find.byType(DropdownButtonFormField<String>));
    await tap(tester, find.text('Lower rack').last);
    expect(find.text('표시 중 1병 · 1종'), findsOneWidget);
    expect(find.text('보유 병 구매 원가 KRW 50,000'), findsOneWidget);
    final lower = (await store.entryForWine(wineId))!
        .bottles
        .singleWhere((b) => b.storageLocation == 'Lower rack');
    await store.setBottleStatus(lower.id, BottleStatus.returned);
    await tester.pumpAndSettle();
    expect(find.text('표시 중 0병 · 0종'), findsOneWidget);
    expect(find.text('조건에 맞는 보유 와인이 없습니다.'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tap(tester, find.text('조건 초기화'));
    expect(find.text('보유 중 3병 · 1종'), findsOneWidget);
    await disposeApp(tester, store);
  });

  testWidgets('Deleting a purchase keeps its stock with unknown cost',
      (tester) async {
    final store = await pumpApp(tester);
    final wineId = await store.addWinePurchase(
        name: 'Preserved stock', purchasePrice: 25000);
    final purchase = (await store.entryForWine(wineId))!.purchases.single;
    await tester.pumpAndSettle();
    await openCellar(tester);
    await tap(tester, find.text('구매한 병만 보기'));
    await store.deletePurchase(purchase.id);
    await tester.pumpAndSettle();
    expect(find.text('표시 중 1병 · 1종'), findsOneWidget);
    expect(find.text('보유 병 구매 원가 KRW 0'), findsOneWidget);
    expect(find.text('가격 미상 1병 제외'), findsOneWidget);
    await reveal(tester, find.textContaining('Preserved stock'));
    await disposeApp(tester, store);
  });

  testWidgets(
      'Consuming the last cellar bottle retains its purchase and tasting',
      (tester) async {
    final store = await pumpApp(tester);
    final wineId =
        await store.addWinePurchase(name: 'Last bottle', purchasePrice: 35000);
    final bottle = (await store.entryForWine(wineId))!.bottles.single;
    final noteId = await store.addTastingNote(
        wineId: wineId, bottleId: bottle.id, memo: 'First taste');
    await tester.pumpAndSettle();
    await openCellar(tester);
    await tap(tester, find.textContaining('Last bottle'));
    await tap(tester, find.byTooltip('보유 병 관리'));
    await tap(tester, find.text('마셨음'));
    await tap(tester, find.widgetWithText(TextButton, '취소'));
    expect((await store.findBottle(bottle.id))!.status, BottleStatus.inStock);
    await tap(tester, find.byTooltip('보유 병 관리'));
    await tap(tester, find.text('마셨음'));
    await tap(tester, find.widgetWithText(FilledButton, '변경'));
    final entry = (await store.entryForWine(wineId))!;
    expect(entry.stockCount, 0);
    expect(entry.purchases.single.purchasedQuantity, 1);
    expect(entry.purchases.single.totalPaidKrw, 35000);
    expect(entry.bottles.single.status, BottleStatus.consumed);
    expect(entry.bottles.single.statusChangedAt, isNull);
    expect((await store.findTastingNote(noteId))!.bottleId, bottle.id);
    await reveal(tester, find.byKey(const ValueKey('cellar-stock-summary')));
    expect(find.text('보유 중 0병 · 0종'), findsOneWidget);
    await tap(tester, find.text('전체 와인 기록'));
    await reveal(tester, find.textContaining('Last bottle'));
    await disposeApp(tester, store);
  });

  testWidgets('Cellar opens bottle editing to update the storage location',
      (tester) async {
    final store = await pumpApp(tester);
    final wineId = await store.addWinePurchase(
        name: 'Move me', purchasePrice: 20000, storageLocation: 'Old shelf');
    await tester.pumpAndSettle();
    await openCellar(tester);
    await tap(tester, find.textContaining('Move me'));
    await tap(tester, find.byTooltip('보유 병 관리'));
    await tap(tester, find.text('보관 위치·병 정보 수정'));
    await enter(tester, '보관 위치', 'Wine fridge');
    await tap(tester, find.widgetWithText(FilledButton, '수정 저장'));
    final entry = (await store.entryForWine(wineId))!;
    expect(entry.bottles.single.storageLocation, 'Wine fridge');
    expect(entry.stockCount, 1);
    expect(entry.purchases.single.totalPaidKrw, 20000);
    await reveal(tester, find.text('1병 · Wine fridge 1병'));
    await disposeApp(tester, store);
  });

  testWidgets('Cellar adds another purchase to a selected existing wine',
      (tester) async {
    final store = await pumpApp(tester);
    final wineId = await store.addWinePurchase(
        name: 'Existing label', purchasePrice: 30000);
    await tester.pumpAndSettle();
    await openCellar(tester);
    await tap(tester, find.widgetWithText(FilledButton, '보유 와인 추가'));
    await enter(tester, '기존 와인 검색', 'Existing');
    await tap(tester, find.textContaining('Existing label'));
    await enter(tester, '구매 수량', '2');
    await enter(tester, '구매 총액', '64000');
    await enter(tester, '보관 위치', 'Cellar A');
    await tap(tester, find.widgetWithText(FilledButton, '저장'));
    expect((await store.database.catalogSnapshot()), hasLength(1));
    final entry = (await store.entryForWine(wineId))!;
    expect(entry.purchases, hasLength(2));
    expect(entry.stockCount, 3);
    expect(find.text('보유 중 3병 · 1종'), findsOneWidget);
    expect(find.text('보유 병 구매 원가 KRW 94,000'), findsOneWidget);
    await disposeApp(tester, store);
  });

  testWidgets('Cellar creates a new wine then opens its purchase form',
      (tester) async {
    final store = await pumpApp(tester);
    await openCellar(tester);
    await tap(tester, find.widgetWithText(FilledButton, '보유 와인 추가'));
    await tap(tester, find.text('새 와인 등록 후 추가'));
    await enter(tester, '이름', 'New home wine');
    await tap(tester, find.widgetWithText(FilledButton, '저장'));
    expect(find.text('구매 추가'), findsOneWidget);
    await enter(tester, '구매 수량', '2');
    await enter(tester, '보관 위치', 'Fridge');
    await tap(tester, find.widgetWithText(FilledButton, '저장'));
    final entry = (await store.database.catalogSnapshot()).single;
    expect(entry.wine.name, 'New home wine');
    expect(entry.stockCount, 2);
    expect(entry.purchases.single.totalPaidKrw, isNull);
    expect(find.text('보유 중 2병 · 1종'), findsOneWidget);
    expect(find.text('가격 미상 2병 제외'), findsOneWidget);
    await disposeApp(tester, store);
  });

  testWidgets('Cellar can add a gift without creating a purchase',
      (tester) async {
    final store = await pumpApp(tester);
    final wineId = await store.createWine(name: 'Gift label');
    await tester.pumpAndSettle();
    await openCellar(tester);
    await tap(tester, find.byTooltip('보유 와인 추가'));
    await tap(tester, find.text('선물받은 병 추가'));
    await tap(tester, find.textContaining('Gift label'));
    expect(find.text('구매 없이 병 추가'), findsOneWidget);
    await enter(tester, '보관 위치', 'Gift shelf');
    await tap(tester, find.widgetWithText(FilledButton, '저장'));
    final entry = (await store.entryForWine(wineId))!;
    expect(entry.purchases, isEmpty);
    expect(entry.bottles.single.acquisitionKind, AcquisitionKind.gift);
    expect(find.text('보유 중 1병 · 1종'), findsOneWidget);
    await disposeApp(tester, store);
  });
}
