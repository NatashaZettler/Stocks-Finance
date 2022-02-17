import 'package:flutter/material.dart';
import 'package:stocks_finance/repository/db/stocks_dao.dart';
import 'package:stocks_finance/repository/model/stock.dart';
import 'package:stocks_finance/ui/components/centered_message.dart';
import 'package:stocks_finance/ui/pages/stocks_detail_page.dart';
import 'package:stocks_finance/ui/views/stocks_favorite_item.dart';
import 'package:stocks_finance/widgets/app_dependency.dart';

class StocksFavoriteView extends StatefulWidget {
  @override
  _StocksFavoriteViewState createState() => _StocksFavoriteViewState();
}

class _StocksFavoriteViewState extends State<StocksFavoriteView> {
  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return FutureBuilder<List<Stock>>(
        future: dependencies!.stocksDAO.getStocksFavorites(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snapshot.data!.length == 0) {
            return CenteredMessage(
              'You do not have favorites stocks',
              icon: Icons.warning,
            );
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.9),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                Stock stock = snapshot.data![index];
                return StocksFavoriteItem(stock);
              });
        });
  }
}
