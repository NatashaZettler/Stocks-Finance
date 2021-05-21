import 'package:flutter/material.dart';
import 'package:stocks_finance/ui/pages/stocks_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(94, 92, 246, 1.0),
      ),
      home: StocksPage(),
    );
  }
}








