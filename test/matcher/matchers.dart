import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stocks_finance/ui/views/stocks_favorite_item.dart';
import 'package:stocks_finance/ui/views/stocks_favorite_view.dart';

void labelBottomNavigationBarItem() {
  final labelBottomNavigationBarItem =
  find.widgetWithText(BottomNavigationBar, 'Favoritas');
  expect(labelBottomNavigationBarItem, findsOneWidget);
}

Future<void> stocksFavoriteView(WidgetTester tester) async {
  final stocksFavoriteView = find.byType(StocksFavoriteView);
  expect(stocksFavoriteView, findsOneWidget);
  await tester.pumpAndSettle();
}

void stocksFavoriteItem() {
  final stocksFavoriteItem = find.byType(StocksFavoriteItem);
  expect(stocksFavoriteItem, findsOneWidget);
}