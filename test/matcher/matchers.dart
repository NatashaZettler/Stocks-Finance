import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stocks_finance/ui/views/stocks_list_view.dart';

void labelBottomNavigationBarItem(String tabBarItem) {
  final labelBottomNavigationBarItem =
      find.widgetWithText(BottomNavigationBar, tabBarItem);
  expect(labelBottomNavigationBarItem, findsOneWidget);
}

Future<void> stocksView(WidgetTester tester, Type newClass) async {
  final stocksFavoriteView = find.byType(newClass);
  expect(stocksFavoriteView, findsOneWidget);
  await tester.pumpAndSettle();
}

void stocksItem(Type newClass) {
  final stocksFavoriteItem = find.byType(newClass);
  expect(stocksFavoriteItem, findsOneWidget);
}

bool verifyItemCardList(Widget widget, String ticker, String name) {
  if (widget is StockItem) {
    return widget.stock.name == name && widget.stock.ticker == ticker;
  }
  return false;
}
