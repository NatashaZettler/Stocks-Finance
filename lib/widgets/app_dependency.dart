import 'package:flutter/material.dart';
import 'package:stocks_finance/repository/api/stocks_api.dart';
import 'package:stocks_finance/repository/db/stocks_dao.dart';

class AppDependencies extends InheritedWidget {
  final StocksDAO? stocksDAO;
  final StocksAPI? stocksAPI;

  AppDependencies({
    @required this.stocksDAO,
    @required this.stocksAPI,
    @required Widget? child,
  }) : super(child: child!);

  static AppDependencies? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDependencies>();

  @override
  bool updateShouldNotify(covariant AppDependencies oldWidget) {
    return stocksDAO != oldWidget.stocksDAO || stocksAPI != oldWidget.stocksAPI;
  }
}
