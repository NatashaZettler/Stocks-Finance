import 'package:flutter/material.dart';
import 'package:stocks_finance/repository/model/stock.dart';
import 'package:stocks_finance/repository/model/stock_trade.dart';
import 'package:stocks_finance/ui/views/stocks_favorite_item_chart.dart';
import 'package:stocks_finance/widgets/app_dependency.dart';
import 'package:transparent_image/transparent_image.dart';

class StocksFavoriteItem extends StatelessWidget {
  final Stock stock;

  StocksFavoriteItem(this.stock);

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return FutureBuilder<List<StockTrade>>(
        future: dependencies!.stocksAPI.getStockTrade(stock.ticker!),
        builder: (ctx, snap) {
          if (!snap.hasData) return Center(child: CircularProgressIndicator());

          bool isUp = _isTradeUp(snap.data!);

          return Card(
            child: Column(
              children: [
                ListTile(
                  leading: getLogo(),
                  title: Text(stock.ticker!),
                  subtitle: Text(stock.name!, maxLines: 1),
                ),
                StocksFavoriteItemChart(tradeList: snap.data!, isUp: isUp),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "\$${double.parse(snap.data!.first.close!).toString()} ",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: isUp ? Colors.blue : Colors.red),
                      ),
                      Text(
                        "(${isUp ? '+' : ''}${_getPercent(snap.data!)}%)",
                        style:
                            TextStyle(color: isUp ? Colors.blue : Colors.red),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget getLogo() {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image:
          "https://s3.polygon.io/logos/${stock.ticker!.toLowerCase()}/logo.png",
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'assets/images/polygon_io.png',
          height: 20,
        );
      },
      height: 30,
    );
  }

  bool _isTradeUp(List<StockTrade> list) {
    StockTrade trade0 = list[0];
    StockTrade trade1 = list[1];

    return double.parse(trade0.close!) > double.parse(trade1.close!);
  }

  String _getPercent(List<StockTrade> list) {
    StockTrade trade0 = list[0];
    StockTrade trade1 = list[1];

    return (100 -
            (double.parse(trade1.close!) * 100 / double.parse(trade0.close!)))
        .toStringAsFixed(2);
  }
}
