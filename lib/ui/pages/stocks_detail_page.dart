import 'package:flutter/material.dart';
import 'package:stocks_finance/repository/api/stocks_api.dart';
import 'package:stocks_finance/repository/model/stock.dart';
import 'package:stocks_finance/repository/model/stock_details.dart';

class StockDetailPage extends StatefulWidget {
  final Stock? stock;

  StockDetailPage({this.stock});

  @override
  _StockDetailPageState createState() => _StockDetailPageState();
}

class _StockDetailPageState extends State<StockDetailPage> {
  var ceo, phone, url, hq_address, country, hq_state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stock!.ticker!),
      ),
      body: FutureBuilder<StockDetails>(
          future: _requestStockDetails(),
          builder: (context, snapshot) {

            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                return stockDetailView(snapshot.data!);
            }
            return Center(child: Text('Stocks not '));
          }),
    );
  }

  Future<StockDetails> _requestStockDetails() async {
    return await StocksAPI.getStockDetails(widget.stock!.ticker!);
  }

  Widget stockDetailView(StockDetails stockDetails) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          padding: EdgeInsets.all(70),
          child: Image.network(stockDetails.logo!),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  ceo = stockDetails.ceo!;
                  phone = stockDetails.phone!;
                  url = stockDetails.url!;
                });
              },
              child: Text('General'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  ceo = stockDetails.hqAddress!;
                  country = stockDetails.country!;
                  url = stockDetails.hqState!;
                });
              },
              child: Text('Address'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  ceo = "TESTE3";
                });
              },
              child: Text('Contact'),
            ),
          ],
        ),
        Column(
          children: [
              Text('CEO: {$ceo}'),
              Text('Phone: {$phone}'),
              Text('URL: {$url}'),

          ],
        ),
      ],
    );
  }
}
