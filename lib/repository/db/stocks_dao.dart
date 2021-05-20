import 'package:stocks_finance/repository/db/stocks_db.dart';
import 'package:stocks_finance/repository/model/stock.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stocks_finance/repository/model/stock_details.dart';

class StocksDAO{

  static const String _tableStocks = 'stocks';
  static const String _tableStockDetails = 'stocks_details';

  static const String tableSqlStocks = 'CREATE TABLE $_tableStocks(ticker TEXT,name TEXT,market TEXT,locale TEXT,primaryExchange TEXT,type TEXT,active BOOLEAN,currencyName TEXT, cik TEXT,compositeFigi TEXT, shareClassFigi TEXT,lastUpdatedUtc TEXT,)';
  static const String tableSqlStocksDetails = 'CREATE TABLE $_tableStockDetails(favorite BOOLEAN, logo TEXT, listdate TEXT,cik TEXT, bloomberg TEXT,lei TEXT, sic INTEGER,country TEXT, industry TEXT,sector TEXT, marketcap INTEGER,employees INTEGER, phone TEXT,ceo TEXT, url TEXT,description TEXT, exchange TEXT,name TEXT, symbol TEXT,exchangeSymbol TEXT, hqAddress TEXT,hqState TEXT, hqCountry TEXT,type TEXT, updated TEXT,tags Uint8List, similar Uint8List,active BOOLEAN,)';

  Future<List<Stock>> findAllStocks() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> data = await db.query(_tableStocks);
    return data.map((element) => Stock.fromJson(element)).toList();
  }

  Future<StockDetails> findStockDetails() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> data = await db.query(_tableStockDetails);
    return data[0] as StockDetails;
  }

}