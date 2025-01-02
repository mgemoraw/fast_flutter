import 'package:fast_app/screens/home.dart';
import 'package:fast_app/screens/list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Home(
    widgetName: MyList().,
    title: ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 8, 72, 104)),
        useMaterial3: true,
      ),
      // home: Home(), //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
