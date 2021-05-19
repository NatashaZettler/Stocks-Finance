import 'package:flutter/material.dart';
import 'package:stocks_finance/repository/api/stocks_api.dart';
import 'package:stocks_finance/repository/model/stock.dart';
import 'package:stocks_finance/repository/model/stock_details.dart';

class StockDetailPage extends StatelessWidget {
  final Stock? stock;

  StockDetailPage({this.stock});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stock!.ticker!),
      ),
      body: FutureBuilder<StockDetails>(
          future: _requestStockDetails(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );

            return stockDetailView(snapshot.data!);
          }),
    );
  }

  Future<StockDetails> _requestStockDetails() async {
    return await StocksAPI.getStockDetails('A');
  }

  Widget stockDetailView(StockDetails stockDetails) {
    return Column(children: [

    ],);
  }
}
