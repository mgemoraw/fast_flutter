import "package:fast_app/models/user.dart";
import 'package:flutter/material.dart';
import "form.dart";
import "list.dart";

class Home extends StatefulWidget {
  final Widget widgetName;
  final String title;
  final int index;
  const Home(
      {super.key,
      required this.widgetName,
      required this.title,
      required this.index});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _currentWidget = MyList();
  var _titles = ['List', 'Form'];
  var _widgets = [MyList(), MyForm(user: User(0, '', '', ''))];
  var _currentIndex = 0;
  var _currentTitle = "List";

  @override
  void initState() {
    super.initState();
    _currentWidget = this.widget.widgetName;
    _currentTitle = this.widget.title;
    _currentIndex = this.widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text(_currentTitle),
            // backgroundColor: Colors.blue,
          ),
          body: _currentWidget,
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
                  _currentTitle = _titles[_currentIndex];
                  _currentWidget = _widgets[_currentIndex];
                });
              })),
    );
  }
}
