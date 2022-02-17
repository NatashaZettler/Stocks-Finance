import 'package:flutter/material.dart';
import 'package:stocks_finance/repository/db/stocks_dao.dart';
import 'package:stocks_finance/repository/model/stock.dart';
import 'package:stocks_finance/ui/components/centered_message.dart';
import 'package:stocks_finance/ui/pages/stocks_detail_page.dart';
import 'package:stocks_finance/widgets/app_dependency.dart';
import '../../repository/api/stocks_api.dart';

class StockListView extends StatefulWidget {
  @override
  _StockListViewState createState() => _StockListViewState();
}

class _StockListViewState extends State<StockListView> {
  bool favoriteIcon = false;

  List<Stock> newList = [];

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context)!;
    return FutureBuilder<List<Stock>>(
        future:
            _requestStocks(dependencies.stocksDAO, dependencies.stocksAPI),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData)
            return CenteredMessage(
              'You do not have favorites stocks',
              icon: Icons.warning,
            );
          return _listView(snapshot.data!, dependencies.stocksDAO);
        });
  }

  Future<List<Stock>> _requestStocks(
      StocksDAO stocksDAO, StocksAPI stocksAPI) async {
    try {
      var api = await stocksAPI.getAllStocks();
      var database = await stocksDAO.getAllStocksFavorites();

      api.forEach((value) {
        if (database.contains(value.ticker)) {
          newList
              .add(Stock(ticker: value.ticker, name: value.name, favorite: 1));
        } else {
          newList.add(value);
          stocksDAO.save(value);
        }
      });
      return newList;
    } on Exception catch (_) {
      if (newList.length == 0) {
        var database = await stocksDAO.getAllStocks();
        newList.addAll(database);
      }
      return newList;
    }
  }

  _listView(List list, StocksDAO? stocksDAO) => ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          Stock stock = list[index];
          return StockItem(stock, stocksDAO!);
        },
      );
}

class StockItem extends StatefulWidget {
  final Stock stock;
  final StocksDAO stocksDAO;

  StockItem(this.stock, this.stocksDAO);

  @override
  _StockItemState createState() => _StockItemState();
}

class _StockItemState extends State<StockItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          widget.stock.ticker!,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            widget.stock.name!,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        trailing: IconButton(
          icon: widget.stock.favorite == 0
              ? Icon(Icons.star_border)
              : Icon(Icons.star),
          onPressed: () {
            setState(() {
              widget.stock.favorite == 0
                  ? widget.stock.setFavorite(1)
                  : widget.stock.setFavorite(0);
              widget.stocksDAO.save(widget.stock);
            });
          },
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StockDetailPage(
              stock: widget.stock,
            ),
          ),
        ),
      ),
    );
  }
}
