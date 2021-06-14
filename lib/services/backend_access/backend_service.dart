import 'package:http/http.dart' as http;
import 'dart:convert';

class BackendService {
  final _HttpRequests http = new _HttpRequests();

  //TODO: Move this to an authentication module.
  dynamic authenticate(String id, String password) async {
    return await http.makePostRequest('auth/login', body: {
      'username': id,
      'password': password,
      'grant_type': 'password',
      'client_id': 'go'
    }, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    });
  }

  dynamic refreshToken(String token) async {
    return await http.makePostRequest('auth/tokens/refresh', body: {
      'refresh_token': token,
      'grant_type': 'refresh_token',
      'client_id': 'go'
    });
  }

  dynamic revokeToken(String token) async {
    return await http.makePostRequest('auth/logout', body: {
      'token': token,
      'token_type_hint': 'access_token',
      'client_id': 'go'
    });
  }

  dynamic userInfo(String token) async {
    return await http
        .makeGetRequest('users', headers: {'Authorization': 'Bearer $token'});
  }
}

class _HttpRequests {
  //TODO: Use environment variables or configuration files.
  String urlBase = 'http://192.168.0.21:3000/';

  dynamic makePostRequest(route, {body, headers}) async {
    var uri = Uri.parse(urlBase + route);
    var response = await http.post(uri, body: body, headers: headers);
    var returnValue = jsonDecode(response.body);

    returnValue['statusCode'] = response.statusCode;

    return returnValue;
  }

  dynamic makeGetRequest(route, {headers}) async {
    var uri = Uri.parse(urlBase + route);
    var response = await http.get(uri, headers: headers);
    var returnValue = jsonDecode(response.body);

    returnValue['statusCode'] = response.statusCode;

    return returnValue;
  }

  dynamic makePutRequest(route, {body, headers}) async {
    var uri = Uri.parse(urlBase + route);
    var response = await http.put(uri, body: body, headers: headers);
    var returnValue = jsonDecode(response.body);

    returnValue['statusCode'] = response.statusCode;

    return returnValue;
  }

  dynamic makeDeleteRequest(route, {body, headers}) async {
    var uri = Uri.parse(urlBase + route);
    var response = await http.delete(uri, body: body, headers: headers);
    var returnValue = jsonDecode(response.body);

    returnValue['statusCode'] = response.statusCode;

    return returnValue;
  }
}
