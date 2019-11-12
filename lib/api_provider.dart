import 'package:http/http.dart' as http;

class ApiProvider {
  
  ApiProvider();

  String apiUrl = 'https://api.fasicare.com/api_app/';

  Future <http.Response> getPost(String func) async {

    return await http.get('$apiUrl/$func');


  }

   Future <http.Response> getPostView(String func,int id) async {

    return await http.get('$apiUrl/$func/$id');

  }


}