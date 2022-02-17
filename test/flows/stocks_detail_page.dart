import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stocks_finance/main.dart';
import 'package:stocks_finance/repository/api/stocks_api.dart';
import 'package:stocks_finance/repository/db/stocks_dao.dart';
import 'package:stocks_finance/repository/model/stock.dart';
import 'package:stocks_finance/repository/model/stock_details.dart';
import 'package:stocks_finance/repository/model/stock_trade.dart';
import 'package:stocks_finance/ui/pages/stocks_detail_page.dart';
import 'package:stocks_finance/ui/pages/stocks_page.dart';
import 'package:stocks_finance/ui/views/stocks_favorite_item.dart';
import 'package:stocks_finance/ui/views/stocks_favorite_view.dart';
import 'package:stocks_finance/ui/views/stocks_list_view.dart';

import '../matcher/matchers.dart';
import 'stocks_detail_page.mocks.dart';

@GenerateMocks([StocksDAO, StocksAPI])
void main() {
  late MockStocksDAO stocksDAO;
  late MockStocksAPI stocksAPI;
  late StockDetails stockDetails;
  late Stock stock;

  setUp(() {
    stocksDAO = MockStocksDAO();
    stocksAPI = MockStocksAPI();
    stock = Stock(ticker: 'A', name: 'Agilent Technologies Inc.', favorite: 0);
    stockDetails = StockDetails(
      logo: null,
      country: 'country',
      industry: 'industry',
      sector: 'sector',
      phone: 'phone',
      ceo: 'ceo',
      url: 'url',
      name: 'Agilent Technologies Inc.',
      symbol: 'symbol',
      hqAddress: 'hqAddress',
      hqState: 'hqState',
      exchangeSymbol: 'exchangeSymbol',
    );
  });

  testWidgets('Should open stocks details screen when user click one stock',
      (tester) async {
    when(stocksAPI.getAllStocks()).thenAnswer((_) async => [stock]);
    when(stocksDAO.getAllStocksFavorites())
        .thenAnswer((_) async => [stock.ticker.toString()]);
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

    when(stocksAPI.getStockDetails('A')).thenAnswer((_) async => stockDetails);

    await stocksView(tester, StocksFavoriteView);

    verify(stocksDAO.getStocksFavorites()).called(1);
    await tester.pumpAndSettle();

    stocksItem(StocksFavoriteItem);

    final clickBottomNavigationBarItem =
        find.widgetWithText(BottomNavigationBar, 'Ações');
    expect(clickBottomNavigationBarItem, findsOneWidget);

    await tester.tap(clickBottomNavigationBarItem);
    await tester.pumpAndSettle();

    final stockListView = find.byType(StockListView);
    expect(stockListView, findsOneWidget);
    verify(stocksAPI.getAllStocks()).called(1);
    verify(stocksDAO.getAllStocksFavorites()).called(1);

    final stockItem = find.byWidgetPredicate((widget) {
      if (widget is StockItem) {
        return widget.stock.name == 'Agilent Technologies Inc.' &&
            widget.stock.ticker == 'A' &&
            widget.stock.favorite == 1;
      }
      return false;
    });
    expect(stockItem, findsOneWidget);
    await tester.tap(stockItem);

    await tester.pumpAndSettle();

    final stocksFavoriteView = find.byType(StockDetailPage);
    expect(stocksFavoriteView, findsOneWidget);
  });

  testWidgets('Should show general information when user click general button',
      (tester) async {
    when(stocksAPI.getAllStocks()).thenAnswer((_) async => [stock]);
    when(stocksDAO.getAllStocksFavorites())
        .thenAnswer((_) async => [stock.ticker.toString()]);
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

    when(stocksAPI.getStockDetails('A')).thenAnswer((_) async => stockDetails);

    await stocksView(tester, StocksFavoriteView);

    verify(stocksDAO.getStocksFavorites()).called(1);
    await tester.pumpAndSettle();

    stocksItem(StocksFavoriteItem);

    final clickBottomNavigationBarItem =
        find.widgetWithText(BottomNavigationBar, 'Ações');
    expect(clickBottomNavigationBarItem, findsOneWidget);

    await tester.tap(clickBottomNavigationBarItem);
    await tester.pumpAndSettle();

    final stockListView = find.byType(StockListView);
    expect(stockListView, findsOneWidget);

    verify(stocksAPI.getAllStocks()).called(1);
    verify(stocksDAO.getAllStocksFavorites()).called(1);

    final stockItem = find.byWidgetPredicate((widget) {
      if (widget is StockItem) {
        return widget.stock.name == 'Agilent Technologies Inc.' &&
            widget.stock.ticker == 'A' &&
            widget.stock.favorite == 1;
      }
      return false;
    });
    expect(stockItem, findsOneWidget);
    await tester.tap(stockItem);

    await tester.pumpAndSettle();

    final stocksFavoriteView = find.byType(StockDetailPage);
    expect(stocksFavoriteView, findsOneWidget);

    final generalButton = find.widgetWithText(ElevatedButton, 'General');
    expect(generalButton, findsOneWidget);
    await tester.tap(generalButton);

    await tester.pumpAndSettle();

    final ceo = find.text('CEO: ceo');
    expect(ceo, findsOneWidget);

    final phone = find.text('Phone: phone');
    expect(phone, findsOneWidget);

    final url = find.text('URL: url');
    expect(url, findsOneWidget);
  });

  testWidgets('Should show address information when user click address button',
      (tester) async {
    when(stocksAPI.getAllStocks()).thenAnswer((_) async => [stock]);
    when(stocksDAO.getAllStocksFavorites())
        .thenAnswer((_) async => [stock.ticker.toString()]);
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

    when(stocksAPI.getStockDetails('A')).thenAnswer((_) async => stockDetails);

    await stocksView(tester, StocksFavoriteView);

    verify(stocksDAO.getStocksFavorites()).called(1);
    await tester.pumpAndSettle();

    stocksItem(StocksFavoriteItem);

    final clickBottomNavigationBarItem =
        find.widgetWithText(BottomNavigationBar, 'Ações');
    expect(clickBottomNavigationBarItem, findsOneWidget);

    await tester.tap(clickBottomNavigationBarItem);
    await tester.pumpAndSettle();

    final stockListView = find.byType(StockListView);
    expect(stockListView, findsOneWidget);

    verify(stocksAPI.getAllStocks()).called(1);
    verify(stocksDAO.getAllStocksFavorites()).called(1);

    final stockItem = find.byWidgetPredicate((widget) {
      if (widget is StockItem) {
        return widget.stock.name == 'Agilent Technologies Inc.' &&
            widget.stock.ticker == 'A' &&
            widget.stock.favorite == 1;
      }
      return false;
    });
    expect(stockItem, findsOneWidget);
    await tester.tap(stockItem);

    await tester.pumpAndSettle();

    final stocksFavoriteView = find.byType(StockDetailPage);
    expect(stocksFavoriteView, findsOneWidget);

    final addressButton = find.widgetWithText(ElevatedButton, 'Address');
    expect(addressButton, findsOneWidget);
    await tester.tap(addressButton);

    await tester.pumpAndSettle();

    final hqAddress = find.text('Hq Address: hqAddress');
    expect(hqAddress, findsOneWidget);

    final country = find.text('Country: country');
    expect(country, findsOneWidget);

    final hqState = find.text('Hq State: hqState');
    expect(hqState, findsOneWidget);
  });

  testWidgets('Should show contact information when user click contact button',
      (tester) async {
    when(stocksAPI.getAllStocks()).thenAnswer((_) async => [stock]);
    when(stocksDAO.getAllStocksFavorites())
        .thenAnswer((_) async => [stock.ticker.toString()]);
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

    when(stocksAPI.getStockDetails('A')).thenAnswer((_) async => stockDetails);

    await stocksView(tester, StocksFavoriteView);

    verify(stocksDAO.getStocksFavorites()).called(1);
    await tester.pumpAndSettle();

    stocksItem(StocksFavoriteItem);

    final clickBottomNavigationBarItem =
        find.widgetWithText(BottomNavigationBar, 'Ações');
    expect(clickBottomNavigationBarItem, findsOneWidget);

    await tester.tap(clickBottomNavigationBarItem);
    await tester.pumpAndSettle();

    final stockListView = find.byType(StockListView);
    expect(stockListView, findsOneWidget);

    verify(stocksAPI.getAllStocks()).called(1);
    verify(stocksDAO.getAllStocksFavorites()).called(1);

    final stockItem = find.byWidgetPredicate((widget) {
      if (widget is StockItem) {
        return widget.stock.name == 'Agilent Technologies Inc.' &&
            widget.stock.ticker == 'A' &&
            widget.stock.favorite == 1;
      }
      return false;
    });
    expect(stockItem, findsOneWidget);
    await tester.tap(stockItem);

    await tester.pumpAndSettle();

    final stocksFavoriteView = find.byType(StockDetailPage);
    expect(stocksFavoriteView, findsOneWidget);

    final contactButton = find.widgetWithText(ElevatedButton, 'Contact');
    expect(contactButton, findsOneWidget);
    await tester.tap(contactButton);

    await tester.pumpAndSettle();

    final industry = find.text('Industry: industry');
    expect(industry, findsOneWidget);

    final sector = find.text('Sector: sector');
    expect(sector, findsOneWidget);

    final name = find.text('Name: Agilent Technologies Inc.');
    expect(name, findsOneWidget);

    final symbol = find.text('Symbol: symbol');
    expect(symbol, findsOneWidget);
  });
}
