import 'package:flutter_test/flutter_test.dart';
import 'package:stocks_finance/repository/model/stock.dart';

void main(){
  Stock? stock;

  setUp((){
    stock = Stock(ticker: 'AC', name: 'Action', favorite: 0);
  });

  test('Should return the stock name when create a stock', (){
    expect(stock?.name, 'Action');
  });

  test('Should return favorite is true when user put this action with favorite', (){
    stock?.setFavorite(1);
    expect(stock?.favorite, 1);
  });

  test('Should convert Map to toJson',(){
    Map<String, dynamic> stockJson = {
      'ticker': stock?.ticker,
      'name': stock?.name,
      'favorite' : stock?.favorite
    };

    final stockFromJson = Stock.fromJson(stockJson);

    expect(stockFromJson.toJson(), stockJson);
  });
}