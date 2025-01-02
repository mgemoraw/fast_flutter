import "package:fast_app/models/user.dart";
import 'package:flutter/material.dart';
import "form.dart";
import "list.dart";

class Home extends StatefulWidget {
  final Widget widgetName;
  const Home({super.key, required this.widgetName});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _currentWidget = MyList();
  var _titles = ['List', 'Form'];
  var _widgets = [MyList(), MyForm(user: User(0, '', '', ''))];
  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentWidget = this.widget.widgetName;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text(_titles[_currentIndex]),
            // backgroundColor: Colors.blue,
          ),
          body: _widgets[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.table_chart), label: 'List'),
                BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Form'),
              ],
              onTap: (value) {
                setState(() {
                  _currentIndex = value;
                });
              })),
    );
  }
}
