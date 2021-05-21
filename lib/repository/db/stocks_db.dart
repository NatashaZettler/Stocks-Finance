import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stocks_finance/repository/db/stocks_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'stocks_finance.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(StocksDAO.tableSqlStocks);
      db.execute(StocksDAO.tableSqlStocksDetails);
    },
    version: 1,
  );
}