import 'package:http/http.dart' as http;
import 'dart:async';
class ApiProvider {
  
  ApiProvider();

  String apiUrl = 'https://api.fasicare.com/api_app/';

  Future <http.Response> getPost(String func) async {

    return await http.get('$apiUrl/$func');


  }

   Future <http.Response> getPostView(String func,int id) async {

    return await http.get('$apiUrl/$func/$id');
 }

 Future <http.Response> postData(String func,data) async {

    return await http.post('$apiUrl/$func',body:"$data", headers: {"Content-Type": "application/json"});

  }
 


}