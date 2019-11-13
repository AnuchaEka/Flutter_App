import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'dart:async';

class Post {

  final String title;


  Post({this.title});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      // userId: json['userId'],
      // id: json['id'],
      title: json['data']['u_name'],
      // body: json['body'],
    );
  }
}


class  AppDrawer extends StatelessWidget {

  bool hasImage = true;
  Icon icon_r = Icon(Icons.keyboard_arrow_right);
  List items =[];

  Future<Post> fetchPost() async {
  final response =
      await http.get('https://api.fasicare.com/api_app/Account/getUser/1');
      
      print(response);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}


  @override
  Widget build(BuildContext context) {
    return Drawer(

  child: Container(
    color: Colors.white,
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
       FutureBuilder<Post>(
         future:fetchPost() ,
         builder: (context, snapshot) {
           if(snapshot.hasData){
           return UserAccountsDrawerHeader(
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
                accountName: Text( snapshot.data.title,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                accountEmail: Text('rianpit@gmail.com',style: TextStyle(fontSize: 12),),
               
              );
           }
         }
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

  }
}

