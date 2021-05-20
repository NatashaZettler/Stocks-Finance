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
  List<String> dataInformation = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(94, 92, 246, 1),
        title: Text(widget.stock!.ticker!),
      ),
      body: FutureBuilder<StockDetails>(
          future: _requestStockDetails(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                return stockDetailView(snapshot.data!);
            }
            return Center(child: Text('Stocks not found'));
          }),
    );
  }

  Future<StockDetails> _requestStockDetails() async {
    return await StocksAPI.getStockDetails(widget.stock!.ticker!);
  }

  Widget stockDetailView(StockDetails stockDetails) {
    return Column(
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
                  dataInformation.clear();
                  dataInformation.add('CEO: ${stockDetails.ceo!}');
                  dataInformation.add('Phone: ${stockDetails.phone!}');
                  dataInformation.add('URL: ${stockDetails.url!}');
                });
              },
              child: Text('General'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  dataInformation.clear();
                  dataInformation.add('Hq Address: ${stockDetails.hqAddress!}');
                  dataInformation.add('Country: ${stockDetails.country!}');
                  dataInformation.add('Hq State: ${stockDetails.hqState!}');
                });
              },
              child: Text('Address'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  dataInformation.clear();
                  dataInformation.add('Industry: ${stockDetails.industry!}');
                  dataInformation.add('Sector: ${stockDetails.sector!}');
                  dataInformation.add('Name: ${stockDetails.name!}');
                  dataInformation.add('Symbol: ${stockDetails.symbol!}');
                  dataInformation
                      .add('Exchange Symbol: ${stockDetails.exchangeSymbol!}');
                });
              },
              child: Text('Contact'),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.2,
                left: 30,
                right: 30),
            child: ListView.builder(
                itemCount: dataInformation.length,
                itemBuilder: (context, index) {
                  return Card(
                   margin: EdgeInsets.all(10),
                      child: Text(
                    dataInformation[index],
                    textAlign: TextAlign.left,
                  ));
                }),
          ),
        ),
      ],
    );
  }
}
