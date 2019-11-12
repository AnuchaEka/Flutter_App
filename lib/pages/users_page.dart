import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  var users;
  bool isLoading = true;

  Future<Null> getUsers() async {
     final response =
      await http.get('https://api.fasicare.com/api_app/stock/stocklist?cat=1&page=1');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    setState(() {
      isLoading = false;
     users = jsonResponse['result'] ;

    });

  } else {
    // If that response was not OK, throw an error.
    print("Connect error");
  }
 
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User list'),),
      body: RefreshIndicator(
        onRefresh: getUsers,
              child: isLoading ? Center( child:CircularProgressIndicator())  
        : Card(
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder:(context,int index) {
            return Column(
              children: <Widget>[
                ListTile(
                  onTap: (){},
                  title: Text(
                    '${users[index]['name']}',
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Text('SKU : ${users[index]['sku']}'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                Divider()
              ],
            );
          },
          itemCount: users != null ? users.length : 0,
          ),
        ),
      ),
    );
  }
} 