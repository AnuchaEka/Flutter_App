import 'package:app_stock/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';


class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

   bool hasImage = true;
    Icon icon_r = Icon(Icons.keyboard_arrow_right);

  List items =[];
  //bool isLoading = true;
  String name;
  String lastname;
  String email;
  String uid;
  String img;
  SharedPreferences sharedPreferences;


  ApiProvider apiProvider = ApiProvider();

  Future fetchPostView() async {
    try {
      final  response = await apiProvider.getPostView('Account/getUser',1);

      //print(response);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        List<Map> streetsList = new List<Map>.from(jsonResponse['data']);

        //print(streetsList[0]['u_name']);

        SharedPreferences prefs =await SharedPreferences.getInstance();
        prefs.setString('u_name', streetsList[0]['u_name']);
        prefs.setString('u_lastname', streetsList[0]['u_lastname']);
        prefs.setString('u_email', streetsList[0]['u_email']);
        prefs.setString('u_id', streetsList[0]['u_id']);
        prefs.setString('img', jsonResponse['img']);
        
        setState(() {
          //isLoading = false;
          //items = jsonResponse['result'];
          //  name = jsonResponse['u_username'];
          //print(post_name);

        });
      }
    } catch (error) {
      setState(() {
        //isLoading = false;

      });
      print(error);
    }
  }

  Future <Null> getUsers() async {

    sharedPreferences = await SharedPreferences.getInstance();
    //List gUser = await prefs.getStringList('u_name');

     setState(() {
          //isLoading = false;
          name = sharedPreferences.getString("u_name");
          lastname = sharedPreferences.getString("u_lastname");
          email = sharedPreferences.getString("u_email");
          uid = sharedPreferences.getString("u_id");
          img = sharedPreferences.getString("img");
         // print(img);
        });

  }



  @override
   void initState() {
     super.initState();
     fetchPostView();
     getUsers();
     //print(_listViewData);
  }


  Widget build(BuildContext context) {


    return Drawer(

  child: Container(
    color: Colors.white,
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
       UserAccountsDrawerHeader(
         currentAccountPicture: img !=null
                ? CircleAvatar(
                  backgroundImage: NetworkImage(img),
                    // backgroundImage: Image.network(img),
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
              '${name} ${lastname}',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text('${email}',style: TextStyle(fontSize: 12),),
           
          ),
           ListTile(
              title: Text('หน้าหลัก'),
              leading: new Icon(FontAwesomeIcons.cubes,color: Colors.black),
              trailing: icon_r,
              onTap: () {
                // Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/mainPage`');
                // Update the state of the app.
                // ...
              },
            ),

          ListTile(
              title: Text('สินค้าทั้งหมด'),
              leading: new Icon(FontAwesomeIcons.cubes,color: Colors.black),
              trailing: icon_r,
              onTap: () {
                // Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/users');
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


  }
}