import 'package:app_stock/api_provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app_stock/pages/users_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List items =[];
  bool isLoading = true;
  bool hasImage = true;

  ApiProvider apiProvider = ApiProvider();

  TextStyle myStyle2 = TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold);
  int currentIndex = 0;
  Icon icon_r = Icon(Icons.keyboard_arrow_right);
    
  Future fetchPost() async {
    try {
      var response = await apiProvider.getPost('Products/getShop');

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        setState(() {
          isLoading = false;
          items = jsonResponse['data'];
          print(items);
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print(error);
    }
  }



// static final List<Map> _listViewData = [
//   {'title':"สินค้าทั้งหมด",'icon':FontAwesomeIcons.cubes},

//   ];

  

  @override

 void initState() {
     super.initState();
     fetchPost();
     //print(_listViewData);
  }

  Widget build(BuildContext context) {

Widget drawer =  Drawer(

  child: Container(
    color: Colors.white,
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
       UserAccountsDrawerHeader(
         currentAccountPicture: hasImage
                ? CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logo-c.png'),
                  )
                : CircleAvatar(
                    backgroundColor: Colors.white70,
                    child: Text(
                      'AB',
                      style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0),
                    ),
                  ),
            accountName: Text(
              'Satit Rianpit',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text('rianpit@gmail.com',style: TextStyle(fontSize: 12),),
           
          ),
          ListTile(
              title: Text('สินค้าทั้งหมด'),
              leading: new Icon(FontAwesomeIcons.cubes,color: Colors.black),
              trailing: icon_r,
              onTap: () {
                // Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/users');
                // Update the state of the app.
                // ...
              },
            ),

        // Column(
        //   children:  _listViewData
        //         .map((data) => ListTile(
        //               title: Text('${data['title']}'),
        //               trailing: icon_r,
        //               leading: Icon(FontAwesomeIcons.cubes,color: Colors.black),
        //               onTap: (){

        //               },
        //             ),)
        //      .toList(),
        // ),
      Column(
        children: <Widget>[
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Center(
             child: Image.asset(
                    'assets/images/logo-c.png',
                height: 150,
	              width: 150,
              ),
           ),
         ),
         Padding(
           padding: const EdgeInsets.all(0),
           child: Text("เวอร์ชัน 1.5",style: TextStyle(fontWeight: FontWeight.bold),),
         ),
         Center(
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text("© สงวนลิขสิทธิ์ 2019 บริษัท ฟาซิแคร์ จำกัด",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),),
           ),
         )
  
        ],
      )
   
             
  
      ],
    
    ),
  
  ),
);

    
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
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(
                'ตั้งค่า',
                style: myStyle2,
              )),
        ]);

 


    return  Scaffold(
      appBar: appBar,
      drawer: drawer,
      floatingActionButton: floatingAction,
      bottomNavigationBar: bottomNavBar,
      body: Center(
        child: Text('Home Screen !!'),
      ),
    );
  }
}