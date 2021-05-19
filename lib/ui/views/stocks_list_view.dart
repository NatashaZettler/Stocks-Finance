import 'package:flutter/material.dart';
import 'package:stocks_finance/repository/model/stock.dart';
import 'package:stocks_finance/ui/pages/stocks_detail_page.dart';
import '../../repository/api/stocks_api.dart';

class StockListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Stock>>(
        future: _requestStocks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          return _listView(snapshot.data!);
        });
  }

  Future<List<Stock>> _requestStocks() async {
    return await StocksAPI.getAllStocks();
  }

  _listView(List list) => ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          Stock stock = list[index];

          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(stock.ticker!),
              subtitle: Text(stock.name!),
              leading: Icon(Icons.monetization_on_outlined),
              trailing: IconButton(
                icon: Icon(Icons.star_border),
                onPressed: () {},
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StockDetailPage(index),
                ),
              ), // MaterialPageRoute(builder: (context) => StockDetails(index))),
            ),
          );
        },
      );
}
