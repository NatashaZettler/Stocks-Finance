import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stocks_finance/repository/api/secrets.dart';
import 'package:stocks_finance/repository/model/stock.dart';

class StocksAPI{

  static Uri get urlBase => Uri.parse('https://api.polygon.io/v3/reference/tickers?apiKey=$API_KEY');

  static Future<List<Stock>> getAllStocks() async{
    final response = await http.get(urlBase);
    Map<dynamic, dynamic> data = jsonDecode(response.body);
    List<dynamic> list = data['results'];

    return list.map((json) => Stock.fromJson(json)).toList();
  }

  Future<Map<String, dynamic>> getStockDetails(String ticker) async{
    Uri urlDetails = Uri.parse('https://api.polygon.io/v1/meta/symbols/$ticker/company?&apiKey=$API_KEY');
    final response = await http.get(urlDetails);
    Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }
}