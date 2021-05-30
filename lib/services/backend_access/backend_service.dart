import 'package:http/http.dart' as http;
import 'dart:convert';

class BackendService {
  //TODO: Use environment variables or configuration files.
  String urlBase = 'http://192.168.0.21:3000/';
  //TODO: Move this to an authentication module.
  dynamic authenticate(id, password) async {
    return makePostRequest('auth/login', {'id': id, 'password': password});
  }

  dynamic userInfo(int id) async {
    return makeGetRequest('users/verify/${id.toString()}');
  }

  dynamic makePostRequest(route, body) async {
    var uri = Uri.parse(urlBase + route);
    var response = await http.post(uri, body: body);
    return jsonDecode(response.body);
  }

  dynamic makeGetRequest(route) async {
    var uri = Uri.parse(urlBase + route);
    var response = await http.get(uri);
    return jsonDecode(response.body);
  }
}
