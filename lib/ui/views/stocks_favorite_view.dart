import 'package:flutter/material.dart';
import 'package:stocks_finance/repository/db/stocks_dao.dart';
import 'package:stocks_finance/repository/model/stock.dart';
import 'package:stocks_finance/ui/components/CenteredMessage.dart';
import 'package:stocks_finance/ui/pages/stocks_detail_page.dart';

class StocksFavoriteView extends StatefulWidget {
  @override
  _StocksFavoriteViewState createState() => _StocksFavoriteViewState();
}

class _StocksFavoriteViewState extends State<StocksFavoriteView> {
  StocksDAO _stocksDAO = StocksDAO();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Stock>>(
        future: _stocksDAO.getStocksFavorites(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          if(snapshot.data!.length == 0){
            return CenteredMessage(
              'You do not have favorites stocks',
              icon: Icons.warning,
            );
          }
          return _listView(snapshot.data!);
        });
  }

  _listView(List list) => ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          Stock stock = list[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                stock.ticker!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  stock.ticker!,
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w300),
                ),
              ),
              // leading: Image.network(
              //   "https://s3.polygon.io/logos/${stock.ticker}/logo.png",
              //   height: 30,
              // ),
              trailing: IconButton(
                icon: stock.favorite == 0
                    ? Icon(Icons.star_border)
                    : Icon(Icons.star),
                onPressed: () {
                  setState(() {
                    stock.favorite == 0
                        ? stock.setFavorite(1)
                        : stock.setFavorite(0);
                    _stocksDAO.save(stock);
                  });
                },
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StockDetailPage(
                    stock: stock,
                  ),
                ),
              ),
            ),
          );
        },
      );
}