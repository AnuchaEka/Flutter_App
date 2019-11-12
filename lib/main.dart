import 'package:app_stock/pages/users_page.dart';
import 'package:app_stock/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

    final routes = <String, WidgetBuilder>{
     '/users': (BuildContext context) => UserPage(),
  };


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fasicare Stock',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo[900],
        fontFamily: 'Prompt'
      ),
      //home: UserPage(),
      home:MainScreen(),
      routes: routes,

    );
  }
}
