// Mocks generated by Mockito 5.0.9 from annotations
// in stocks_finance/test/flows/stocks_list_view_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:stocks_finance/repository/api/stocks_api.dart' as _i6;
import 'package:stocks_finance/repository/db/stocks_dao.dart' as _i3;
import 'package:stocks_finance/repository/model/stock.dart' as _i5;
import 'package:stocks_finance/repository/model/stock_details.dart' as _i2;
import 'package:stocks_finance/repository/model/stock_trade.dart' as _i7;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeStockDetails extends _i1.Fake implements _i2.StockDetails {}

/// A class which mocks [StocksDAO].
///
/// See the documentation for Mockito's code generation for more information.
class MockStocksDAO extends _i1.Mock implements _i3.StocksDAO {
  MockStocksDAO() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i5.Stock>> getAllStocks() =>
      (super.noSuchMethod(Invocation.method(#getAllStocks, []),
              returnValue: Future<List<_i5.Stock>>.value(<_i5.Stock>[]))
          as _i4.Future<List<_i5.Stock>>);
  @override
  _i4.Future<List<String>> getAllStocksFavorites() =>
      (super.noSuchMethod(Invocation.method(#getAllStocksFavorites, []),
              returnValue: Future<List<String>>.value(<String>[]))
          as _i4.Future<List<String>>);
  @override
  _i4.Future<List<_i5.Stock>> getStocksFavorites() =>
      (super.noSuchMethod(Invocation.method(#getStocksFavorites, []),
              returnValue: Future<List<_i5.Stock>>.value(<_i5.Stock>[]))
          as _i4.Future<List<_i5.Stock>>);
  @override
  _i4.Future<_i2.StockDetails> findStockDetails() =>
      (super.noSuchMethod(Invocation.method(#findStockDetails, []),
              returnValue: Future<_i2.StockDetails>.value(_FakeStockDetails()))
          as _i4.Future<_i2.StockDetails>);
  @override
  _i4.Future<int> save(_i5.Stock? stock) =>
      (super.noSuchMethod(Invocation.method(#save, [stock]),
          returnValue: Future<int>.value(0)) as _i4.Future<int>);
  @override
  _i4.Future<bool?> searchStock(String? ticker) =>
      (super.noSuchMethod(Invocation.method(#searchStock, [ticker]),
          returnValue: Future<bool?>.value()) as _i4.Future<bool?>);
}

/// A class which mocks [StocksAPI].
///
/// See the documentation for Mockito's code generation for more information.
class MockStocksAPI extends _i1.Mock implements _i6.StocksAPI {
  MockStocksAPI() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i5.Stock>> getAllStocks() =>
      (super.noSuchMethod(Invocation.method(#getAllStocks, []),
              returnValue: Future<List<_i5.Stock>>.value(<_i5.Stock>[]))
          as _i4.Future<List<_i5.Stock>>);
  @override
  _i4.Future<_i2.StockDetails> getStockDetails(String? ticker) =>
      (super.noSuchMethod(Invocation.method(#getStockDetails, [ticker]),
              returnValue: Future<_i2.StockDetails>.value(_FakeStockDetails()))
          as _i4.Future<_i2.StockDetails>);
  @override
  _i4.Future<List<_i7.StockTrade>> getStockTrade(String? ticker) =>
      (super.noSuchMethod(Invocation.method(#getStockTrade, [ticker]),
              returnValue:
                  Future<List<_i7.StockTrade>>.value(<_i7.StockTrade>[]))
          as _i4.Future<List<_i7.StockTrade>>);
}
