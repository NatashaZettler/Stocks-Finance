import 'package:flutter/material.dart';
import 'package:stocks_finance/repository/model/stock.dart';

class StocksFavoriteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _gridItem(Stock());
      },
    );
  }

  _gridItem(Stock stock) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Image.network(
            "https://s3.polygon.io/logos/aapl/logo.png",
            height: 30,
          ),
          title: Text(
            "[AAPL] Apple Inc.",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "+\$128.08 (0.23%)",
              style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w300),
            ),
          ),
          trailing: IconButton(icon: Icon(Icons.star), onPressed: () {}),
        ),
      ),
    );
  }
}
