import 'package:stocks_finance/repository/db/stocks_db.dart';
import 'package:stocks_finance/repository/model/stock.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stocks_finance/repository/model/stock_details.dart';

class StocksDAO {
  static const String _tableStocks = 'stocks';
  static const String _tableStockDetails = 'stocks_details';

  static const String tableSqlStocks =
      'CREATE TABLE $_tableStocks(ticker TEXT primary key, name TEXT, favorite INTEGER)';
  static const String tableSqlStocksDetails =
      'CREATE TABLE $_tableStockDetails(logo TEXT, country TEXT, industry TEXT,sector TEXT, phone TEXT,ceo TEXT, url TEXT, name TEXT, symbol TEXT, hqAddress TEXT,hqState TEXT, exchangeSymbol TEXT)';

  Future<List<Stock>> getAllStocks() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> data = await db.query(_tableStocks);
    return data.map((element) => Stock.fromJson(element)).toList();
  }

  Future<List<String>> getAllStocksFavorites() async {
    final Database database = await getDatabase();
    List<Map<String, dynamic>> data =
        await database.rawQuery('SELECT * FROM stocks WHERE favorite = ?', [1]);
    return data.map((element) => element['ticker'].toString()).toList();
  }

  Future<List<Stock>> getStocksFavorites() async {
    final Database database = await getDatabase();
    List<Map<String, dynamic>> data =
        await database.rawQuery('SELECT * FROM stocks WHERE favorite = ?', [1]);
    return data
        .map((element) => Stock(
            ticker: element['ticker'], name: element['name'], favorite: 1))
        .toList();
  }

  Future<StockDetails> findStockDetails() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> data = await db.query(_tableStockDetails);
    return data[0] as StockDetails;
  }

  Future<int> save(Stock stock) async {
    final Database database = await getDatabase();

    if (await searchStock(stock.ticker!) == true) {
      return await database.rawUpdate(
          'UPDATE stocks SET favorite = ? WHERE ticker = ?',
          [stock.favorite, stock.ticker]);
    }

    Map<String, dynamic> stockMap = _toMap(stock);
    return database.insert(_tableStocks, stockMap);
  }

  Future<bool?> searchStock(String ticker) async {
    final Database database = await getDatabase();
    var data = await database
        .rawQuery('SELECT * FROM stocks WHERE ticker = ?', [ticker]);
    return data.isNotEmpty;
  }

  Map<String, dynamic> _toMap(Stock stock) {
    final Map<String, dynamic> stockMap = Map();
    stockMap['ticker'] = stock.ticker;
    stockMap['name'] = stock.name;
    stockMap['favorite'] = stock.favorite;
    return stockMap;
  }
}
