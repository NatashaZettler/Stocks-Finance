import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stocks_finance/repository/api/secrets.dart';
import 'package:stocks_finance/repository/model/stock.dart';
import 'package:stocks_finance/repository/model/stock_details.dart';
import 'package:stocks_finance/repository/model/stock_trade.dart';

class StocksAPI {
  static Uri get urlBase =>
      Uri.parse('https://api.polygon.io/v3/reference/tickers?apiKey=$API_KEY');

  static Future<List<Stock>> getAllStocks() async {
    final response = await http.get(urlBase);
    Map<dynamic, dynamic> data = jsonDecode(response.body);
    List<dynamic> list = data['results'];

    return list.map((json) => Stock.fromJson(json)).toList();
  }

  static Future<StockDetails> getStockDetails(String ticker) async {
    Uri urlDetails = Uri.parse(
        'https://api.polygon.io/v1/meta/symbols/$ticker/company?&apiKey=$API_KEY');
    final response = await http.get(urlDetails);
    Map<String, dynamic> data = jsonDecode(response.body);

    return StockDetails.fromJson(data);
  }

  static Future<List<StockTrade>> getStockTrade(String ticker) async {
    Uri url = Uri.parse(
        "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$ticker&apikey=$API_KEY_ALPHA");
    final response = await http.get(url);
    Map<String, dynamic> data = jsonDecode(response.body);
    Map<String, dynamic> trades = data[data.keys.last];

    return trades.entries
        .map((json) => StockTrade.fromJson(json.key, json.value))
        .toList();
  }
}
