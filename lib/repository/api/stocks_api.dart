import 'dart:convert';

import 'package:http/http.dart' as http;

class StocksAPI{

  static Uri get urlBase => Uri.parse('https://api.polygon.io/v3/reference/tickers?apiKey=');

  Future<Map<String, dynamic>> getAllStocks() async{
    final response = await http.get(urlBase);
    Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> getStockDetails(String ticker) async{
    Uri urlDetails = Uri.parse('https://api.polygon.io/v1/meta/symbols/$ticker/company?&apiKey=');
    final response = await http.get(urlDetails);
    Map<String, dynamic> data = jsonDecode(response.body);
    return data;

  }
}