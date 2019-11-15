import 'package:app_stock/Widget/drawer.dart';
import 'package:app_stock/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_stock/pages/users_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  TextStyle myStyle2 = TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold);
  int currentIndex = 0;

    
  



// static final List<Map> _listViewData = [
//   {'title':"สินค้าทั้งหมด",'icon':FontAwesomeIcons.cubes},

//   ];

  

  @override


  Widget build(BuildContext context) {

//Widget drawer =  

    
  Widget appBar = AppBar(
        title: Text('จัดการสต๊อกสินค้าฟาซิแคร์',style: TextStyle(fontSize: 16.0),),
        actions: <Widget>[
          // IconButton(icon: Icon(Icons.home),
          // onPressed: () {},
          // ),
          IconButton(icon: Icon(Icons.account_circle)
          ,onPressed: () {}
          ,)
        ],
      );

 Widget floatingAction = FloatingActionButton(
   onPressed: () {},
      child: Icon(Icons.add)
   );

 Widget bottomNavBar = BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                'หน้าหลัก',
                style: myStyle2,
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text(
                'ข้อมูลส่วนตัว',
                style: myStyle2,
              )
              
              ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(
                'ตั้งค่า',
                style: myStyle2,
              )),
             
        ]);

 


    return  Scaffold(
      appBar: appBar,
      drawer: AppDrawer(),
      floatingActionButton: floatingAction,
      bottomNavigationBar: bottomNavBar,
      body: Center(
        child: Text('Home Screen !!'),
      ),
    );
  }
}