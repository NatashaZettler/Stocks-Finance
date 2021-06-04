import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stocks_finance/main.dart';
import 'package:stocks_finance/repository/api/stocks_api.dart';
import 'package:stocks_finance/repository/db/stocks_dao.dart';
import 'package:stocks_finance/repository/model/stock.dart';
import 'package:stocks_finance/repository/model/stock_trade.dart';
import 'package:stocks_finance/ui/components/centered_message.dart';
import 'package:stocks_finance/ui/pages/stocks_page.dart';
import 'package:stocks_finance/ui/views/stocks_favorite_item.dart';
import 'package:stocks_finance/ui/views/stocks_favorite_view.dart';

import '../matcher/matchers.dart';
import 'stocks_list_view_test.mocks.dart';

@GenerateMocks([StocksDAO, StocksAPI])
void main() {
  late MockStocksDAO stocksDAO;
  late MockStocksAPI stocksAPI;

  setUp(() {
    stocksDAO = MockStocksDAO();
    stocksAPI = MockStocksAPI();
  });

  testWidgets('Should not have favorites stocks when user mark not favorite',
      (WidgetTester tester) async {
    when(stocksDAO.getStocksFavorites()).thenAnswer((_) async => []);

    await tester.pumpWidget(MyApp(
      stocksDAO: stocksDAO,
      stocksAPI: stocksAPI,
    ));

    final stocksPage = find.byType(StocksPage);
    expect(stocksPage, findsOneWidget);

    labelBottomNavigationBarItem('Favoritas');

    final stockListView = find.byType(StocksFavoriteView);
    expect(stockListView, findsOneWidget);

    verify(stocksDAO.getStocksFavorites()).called(1);
    await tester.pumpAndSettle();

    final centeredMessage = find.byWidgetPredicate((widget) {
      if (widget is CenteredMessage) {
        return widget.message == 'You do not have favorites stocks' &&
            widget.icon == Icons.warning;
      }
      return false;
    });
    expect(centeredMessage, findsOneWidget);
  });

  testWidgets(
      'Should have favorites stocks when user did mark these stocks like favorite',
      (WidgetTester tester) async {
    final stock = Stock(ticker: 'A', name: 'B', favorite: 0);
    when(stocksDAO.getStocksFavorites()).thenAnswer((_) async => [stock]);

    await tester.pumpWidget(MyApp(
      stocksDAO: stocksDAO,
      stocksAPI: stocksAPI,
    ));

    final stocksPage = find.byType(StocksPage);
    expect(stocksPage, findsOneWidget);

    labelBottomNavigationBarItem('Favoritas');

    final stockTrade = StockTrade(
        date: 'A', open: 'A', high: 'A', low: 'A', close: '2.3', volume: 'A');
    when(stocksAPI.getStockTrade(any))
        .thenAnswer((_) async => [stockTrade, stockTrade]);

    await stocksView(tester, StocksFavoriteView);

    verify(stocksDAO.getStocksFavorites()).called(1);
    await tester.pumpAndSettle();

    stocksItem(StocksFavoriteItem);
  });
}