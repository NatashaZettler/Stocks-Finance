import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Stocks Finance'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      body: _selectedIndex == 0 ? favoriteGridView() : stockListView(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget favoriteGridView() {
  return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        return GridTile(
            child: InkWell(
              child: Text('Botão'),
              onTap: () => print('Funciona'),
            ));
      });
}

Widget stockListView() {
  return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('AÇÃO'),
            subtitle: Text('AÇÃO'),
            trailing: IconButton(
              icon: Icon(Icons.map), onPressed: () => print('FOIII'),));

      });
}
