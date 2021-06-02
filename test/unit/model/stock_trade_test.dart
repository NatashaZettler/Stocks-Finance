import 'package:flutter_test/flutter_test.dart';
import 'package:stocks_finance/repository/model/stock_trade.dart';

void main() {
  StockTrade? stockTrace;

  setUp(() {
    stockTrace = StockTrade(
        date: 'key',
        open: 'open',
        high: 'high',
        low: 'low',
        close: 'close',
        volume: 'volume');
  });

  test('Should return the stockTrace open when create a stockTrace', () {
    expect(stockTrace?.open, 'open');
  });

  test('Should convert Map to toJson', () {
    Map<String, dynamic> stockTraceJson = {
      '1. open': stockTrace?.open,
      '2. high': stockTrace?.high,
      '3. low': stockTrace?.low,
      '4. close': stockTrace?.close,
      '5. volume': stockTrace?.volume
    };

    final stockFromJson = StockTrade.fromJson('key', stockTraceJson);

    expect(stockFromJson.toJson(), stockTraceJson);
  });
}
