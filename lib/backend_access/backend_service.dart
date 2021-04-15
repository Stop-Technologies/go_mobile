import 'package:http/http.dart' as http;
import 'dart:convert';

class BackendService {
  //TODO: Use environment variables or configuration files.
  String urlBase = 'http://localhost:3000/';
  //TODO: Move this to an authentication module.
  dynamic authenticate(id, password) async {
    return makeRequest('users/login', {'id': id, 'password': password});
  }

  dynamic makeRequest(route, body) async {
    var uri = Uri.parse(urlBase + route);
    var response = await http.post(uri, body: body);
    return jsonDecode(response.body);
  }
}
