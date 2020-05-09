import 'package:flutter/material.dart';
import 'package:new_absensi/beranda.dart';
import 'package:new_absensi/kalender.dart';
import 'package:new_absensi/log_book.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedTabIndex=0;

  void _onNavBarTapped(int index){
    setState(() {
      _selectedTabIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {

        final _listPage=<Widget>[
      new Beranda(),
      new Log_book(),
      new Kalender(),
    ];

    final _bottomNavBarItems=<BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title:Text('Beranda'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.book),
        title:Text('Log Book'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.calendar_today),
        title:Text('Kalender'),
      ),
    ];

    final _bottomNavBar=BottomNavigationBar(
      items: _bottomNavBarItems,
      currentIndex: _selectedTabIndex,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
      onTap: _onNavBarTapped,
    );


    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Center(
        child:_listPage[_selectedTabIndex],
        
      ),
      bottomNavigationBar:_bottomNavBar,
    );
  }
}
