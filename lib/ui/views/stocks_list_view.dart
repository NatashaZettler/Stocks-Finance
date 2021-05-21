import 'package:flutter/material.dart';
import 'package:stocks_finance/repository/db/stocks_dao.dart';
import 'package:stocks_finance/repository/model/stock.dart';
import 'package:stocks_finance/ui/components/CenteredMessage.dart';
import 'package:stocks_finance/ui/pages/stocks_detail_page.dart';
import '../../repository/api/stocks_api.dart';

class StockListView extends StatefulWidget {
  @override
  _StockListViewState createState() => _StockListViewState();
}

class _StockListViewState extends State<StockListView> {
  final StocksDAO _stocksDAO = StocksDAO();

  bool favoriteIcon = false;

  List<Stock> newList = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Stock>>(
        future: _requestStocks(),
        builder: (context, snapshot) {

          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData)
            return CenteredMessage(
              'You do not have favorites stocks',
              icon: Icons.warning,
            );
          return _listView(snapshot.data!);
        });
  }

  Future<List<Stock>> _requestStocks() async {

    var api = await StocksAPI.getAllStocks();
    var database = await _stocksDAO.getAllStocksFavorites();

    api.forEach((value) {
        if(database.contains(value.ticker)){
          newList.add(Stock(ticker:value.ticker, name: value.name, favorite: 1));
        }else{
          newList.add(value);
        }
    });

    return newList;
  }

  _listView(List list) =>
      ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          Stock stock = list[index];
          return _listItem(stock);
        },
      );

  _listItem(Stock stock) {
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
        trailing: IconButton(
          icon: stock.favorite == 0 ? Icon(Icons.star_border) : Icon(
              Icons.star),
          onPressed: () {
            setState(() {
              stock.favorite == 0 ? stock.setFavorite(1) : stock
                  .setFavorite(0);
              _stocksDAO.save(stock);
            });
          },
        ),
        onTap: () =>
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    StockDetailPage(
                      stock: stock,
                    ),
              ),
            ),
      ),
    );
  }
}