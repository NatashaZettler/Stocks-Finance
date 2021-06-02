import 'package:flutter/material.dart';
import 'package:stocks_finance/repository/api/stocks_api.dart';
import 'package:stocks_finance/repository/db/stocks_dao.dart';
import 'package:stocks_finance/ui/pages/stocks_page.dart';
import 'package:stocks_finance/widgets/app_dependency.dart';

void main() {
  runApp(MyApp(
    stocksDAO: StocksDAO(),
    stocksAPI: StocksAPI(),
  ));
}

class MyApp extends StatelessWidget {
  final StocksDAO stocksDAO;
  final StocksAPI stocksAPI;

  MyApp({required this.stocksDAO, required this.stocksAPI});

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      stocksDAO: this.stocksDAO,
      stocksAPI: this.stocksAPI,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(94, 92, 246, 1.0),
        ),
        home: StocksPage(),
      ),
    );
  }
}
