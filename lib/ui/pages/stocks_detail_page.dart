import 'package:flutter/material.dart';

class StockDetailPage extends StatelessWidget {
  final int index;

  StockDetailPage(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stocks Finance'),
      ),
      body: Container(
        color: Colors.purple,
      ),
    );
  }
}