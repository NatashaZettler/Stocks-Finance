import 'package:flutter/material.dart';
import 'package:stocks_finance/repository/api/stocks_api.dart';
import 'package:stocks_finance/ui/pages/stocks_detail_page.dart';

class StocksFavoriteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        return GridTile(
          header: Text('GRIDTILE'),
          child: InkWell(
            onTap: () {}
            //     Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => StockDetailPage(),
            //   ),
            // ),
          ),
        );
      },
    );
  }
}