import 'package:flutter_test/flutter_test.dart';
import 'package:stocks_finance/repository/model/stock_details.dart';
import 'package:stocks_finance/repository/model/stock_trade.dart';

void main() {
  late StockDetails stockDetails;

  setUp(() {
    stockDetails = StockDetails(
        logo: 'logo',
        country: 'country',
        industry: 'industry',
        sector: 'sector',
        phone: 'phone',
        ceo: 'ceo',
        url: 'url',
        name: 'name',
        symbol: 'symbol',
        exchangeSymbol: 'exchangeSymbol',
        hqAddress: 'hqAddress',
        hqState: 'hqState');
  });

  test('Should return the stock details name when create a StockDetails', () {
    expect(stockDetails.name, 'name');
  });

  test('Should convert Map to toJson', () {
    Map<String, dynamic> stockDetailsJson = {
      'logo': stockDetails.logo,
      'country': stockDetails.country,
      'industry': stockDetails.industry,
      'sector': stockDetails.sector,
      'phone': stockDetails.phone,
      'ceo': stockDetails.ceo,
      'url': stockDetails.url,
      'name': stockDetails.name,
      'symbol': stockDetails.symbol,
      'exchangeSymbol': stockDetails.exchangeSymbol,
      'hq_address': stockDetails.hqAddress,
      'hq_state': stockDetails.hqState,
    };

    final stockFromJson = StockDetails.fromJson(stockDetailsJson);

    expect(stockFromJson.toJson(), stockDetailsJson);
  });
}
