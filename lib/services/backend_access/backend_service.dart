import 'package:http/http.dart' as http;
import 'dart:convert';

/// The class BackendService is used to generate structured querys to the API
/// endpoints in order to properly interact with the backend service
class BackendService {
  final _HttpRequests http = new _HttpRequests();

  /// Is an asyncronous function used to generate a structured post query to
  /// authenticate in the backend service
  /// * return the API response
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

  /// Is an asyncronous function used to generate a structured post query to
  /// refresh the access tokens to the backend service
  /// * return the API response
  dynamic refreshToken(String token) async {
    return await http.makePostRequest('auth/tokens/refresh', body: {
      'refresh_token': token,
      'grant_type': 'refresh_token',
      'client_id': 'go'
    });
  }

  /// Is an asyncronous function used to generate a structured post query to
  /// revoke the access tokens to the backend service
  /// * return the API response
  dynamic revokeToken(String token) async {
    return await http.makePostRequest('auth/logout', body: {
      'token': token,
      'token_type_hint': 'access_token',
      'client_id': 'go'
    });
  }

  /// Is an asyncronous function used to generate a structured get query to
  /// get access to user data stored in the backend service
  /// * return the API response
  dynamic userInfo(String token) async {
    return await http
        .makeGetRequest('users', headers: {'Authorization': 'Bearer $token'});
  }

  /// Is an asyncronous function used to generate a structures get query to
  /// get access to guest data stored in the backend service
  /// * return the API response
  dynamic guestInfo(String token, String id) async {
    return await http.makeGetRequest('permissions/access/$id',
        headers: {'Authorization': 'Bearer $token'});
  }
}

/// The private class _HttpRequests is used to communicate with the API endpoints
/// to send querys and get data from the backend service
class _HttpRequests {
  //TODO: Use environment variables or configuration files.
  String urlBase = 'http://192.168.0.11:3000/';

  /// Is an asyncronous function used to generate a post request to the API
  /// endpoints with a given route, body and headers
  /// * return the API response
  dynamic makePostRequest(route, {body, headers}) async {
    var uri = Uri.parse(urlBase + route);
    var response = await http.post(uri, body: body, headers: headers);
    var returnValue = jsonDecode(response.body);

    returnValue['statusCode'] = response.statusCode;

    return returnValue;
  }

  /// Is an asyncronous function used to generate a get request to the API
  /// endpoints with a given route and headers
  /// * return the API response
  dynamic makeGetRequest(route, {headers}) async {
    var uri = Uri.parse(urlBase + route);
    var response = await http.get(uri, headers: headers);
    var returnValue = jsonDecode(response.body);

    returnValue['statusCode'] = response.statusCode;

    return returnValue;
  }

  /// Is an asyncronous function used to generate a put request to the API
  /// endpoints with a given route, body and headers
  /// * return the API response
  dynamic makePutRequest(route, {body, headers}) async {
    var uri = Uri.parse(urlBase + route);
    var response = await http.put(uri, body: body, headers: headers);
    var returnValue = jsonDecode(response.body);

    returnValue['statusCode'] = response.statusCode;

    return returnValue;
  }

  /// Is an asyncronous function used to generate a delete request to the API
  /// endpoints with a given route, body and headers
  /// * return the API response
  dynamic makeDeleteRequest(route, {body, headers}) async {
    var uri = Uri.parse(urlBase + route);
    var response = await http.delete(uri, body: body, headers: headers);
    var returnValue = jsonDecode(response.body);

    returnValue['statusCode'] = response.statusCode;

    return returnValue;
  }
}
