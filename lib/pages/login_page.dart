import 'package:app_stock/screens/main_screen.dart';
import 'package:flutter/material.dart';

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

      Map bodyData = {"u_username": ctrlUsername.text, "u_password": ctrlPassword.text};
      final  response = await apiProvider.postData('Account/login',jsonEncode(bodyData));

      //print(response);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

       //print(jsonResponse);

       // List<Map> streetsList = new List<Map>.from(jsonResponse['data']);

        //print(jsonResponse['message']);
        
        if(jsonResponse['status']){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
          //print(streetsList);

        }else{

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text("แจ้งเตือน!!",textAlign: TextAlign.center,style: TextStyle(fontSize: 16),),
                              content: new Text("ชื่อผู้ใช้งานหรือรหัสผ่านไม่ถูกต้อง",style: TextStyle(fontSize: 13),),
                              actions: <Widget>[
                                // usually buttons at the bottom of the dialog
                                new FlatButton(
                                  child: new Text("ตกลง"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
               

        }

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