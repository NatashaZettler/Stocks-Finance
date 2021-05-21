import 'package:flutter/material.dart';
import 'package:stocks_finance/ui/views/stocks_favorite_view.dart';
import 'package:stocks_finance/ui/views/stocks_list_view.dart';

class StocksPage extends StatefulWidget {
  StocksPage({Key? key}) : super(key: key);

  @override
  _StocksPageState createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  int _selectedIndex = 0;
  StocksFavoriteView? favoriteView;
  StockListView? listView;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(favoriteView == null) favoriteView = StocksFavoriteView();
    if(listView == null) listView = StockListView();

    return Scaffold(
      appBar: AppBar(
        title: Text('Stocks Finance'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(label: 'Favoritas', icon: Icon(Icons.star)),
          BottomNavigationBarItem(
              label: 'Ações', icon: Icon(Icons.monetization_on)),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
      body: _selectedIndex == 0 ? favoriteView : listView,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
