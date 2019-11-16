import 'package:flutter/material.dart';
import 'package:app_stock/pages/home_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:app_stock/api_provider.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

SharedPreferences sharedPreferences;

ApiProvider apiProvider = ApiProvider();

final _formKey = GlobalKey<FormState>();


TextEditingController ctrlUsername = TextEditingController();
TextEditingController ctrlPassword = TextEditingController();



// void _doLogin(){
//   print(ctrlUsername.text);
//   print(ctrlPassword.text);

//   if(_formKey.currentState.validate()){
//     print('OK');
//   }else{
//     print('Failed');
//   }
// }


Future<Null> _doLogin() async {

  //  print(ctrlUsername.text);
  // print(ctrlPassword.text);

    if(_formKey.currentState.validate()){
      print('OK');
    }else{
      print('Failed');
    }


    try {

      Map bodyData = {"username": ctrlUsername.text, "password": ctrlPassword.text};
      final  response = await apiProvider.postData('Account/login',bodyData);

      //print(response);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

       print(jsonResponse);

        // List<Map> streetsList = new List<Map>.from(jsonResponse['data']);

        //print(streetsList[0]['u_name']);

        // SharedPreferences prefs =await SharedPreferences.getInstance();
        // prefs.setString('u_name', streetsList[0]['u_name']);
        // prefs.setString('u_lastname', streetsList[0]['u_lastname']);
        // prefs.setString('u_email', streetsList[0]['u_email']);
        // prefs.setString('u_id', streetsList[0]['u_id']);
        // prefs.setString('img', jsonResponse['img']);
        
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



Future<Null> getToken() async {

sharedPreferences  = await SharedPreferences.getInstance();


}

  @override

  void initState(){
    super.initState();
    getToken();
  
}
  
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/images/logo.jpg'),
      ),
    );

    final email = TextFormField(
      controller: ctrlUsername,
      validator:  (String value){
        if(value.isEmpty) return 'กรุณาระบุชื่อผู้ใช้งาน';
      },
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'ชื่อผู้ใช้งาน',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: ctrlPassword,
      autofocus: false,
      obscureText: true,
       validator:  (String value){
        if(value.isEmpty) return 'กรุณาระบุรหัสผ่าน';
      },
      decoration: InputDecoration(
        hintText: 'รหัสผ่าน',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () =>_doLogin(),
        padding: EdgeInsets.all(12),
        color: Colors.indigo,
        child: Text('เข้าสู่ระบบ', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'ลืมรหัสผ่าน?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
       backgroundColor: Colors.white,
      body: Center(
        child: Form(
            key: _formKey,
            child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              email,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 24.0),
              loginButton,
              forgotLabel
            ],
          ),
        ),
      ),
    );
  }
}