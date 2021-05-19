import 'package:flutter/material.dart';
import 'package:stocks_finance/ui/views/stocks_favorite_view.dart';
import 'package:stocks_finance/ui/views/stocks_list_view.dart';

class StocksPage extends StatefulWidget {
  StocksPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _StocksPageState createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(label: 'TESTE', icon: Icon(Icons.add)),
          BottomNavigationBarItem(label: 'TESTE2', icon: Icon(Icons.add)),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
      body: _selectedIndex == 0 ? StocksFavoriteView() : StockListView(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}