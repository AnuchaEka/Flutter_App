import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    
  Widget appBar =AppBar(
        title:Text('หน้าแรก') ,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.home),onPressed: () {},),
          IconButton(icon: Icon(Icons.account_circle),onPressed: () {},)
        ],
      );
   Widget drawer =  Drawer(
  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the drawer if there isn't enough vertical
  // space to fit everything.
  child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child: Text('Drawer Header'),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),
      ListTile(
        title: Text('Item 1'),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      ),
      ListTile(
        title: Text('Item 2'),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      ),
    ],
  ),
);


    return Scaffold(
      appBar: appBar,
      drawer:drawer,
      body: Center(child: Text('Home Screen'),),
    );
  }
}