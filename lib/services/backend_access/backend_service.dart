import 'package:http/http.dart' as http;
import 'dart:convert';

/// The class BackendService is used to generate structured querys to the API
/// endpoints in order to properly interact with the backend service
class BackendService {
  final _HttpRequests _http = new _HttpRequests();

  /// Is an asyncronous function used to generate a structured post query to
  /// authenticate in the backend service
  /// * return the API response
  dynamic authenticate(String id, String password) async {
    return await _http.makePostRequest('auth/login', body: {
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
    return await _http.makePostRequest('auth/tokens/refresh', body: {
      'refresh_token': token,
      'grant_type': 'refresh_token',
      'client_id': 'go'
    });
  }

  /// Is an asyncronous function used to generate a structured post query to
  /// revoke the access tokens to the backend service
  /// * return the API response
  dynamic revokeToken(String token) async {
    return await _http.makePostRequest('auth/logout', body: {
      'token': token,
      'token_type_hint': 'access_token',
      'client_id': 'go'
    });
  }

  /// Is an asyncronous function used to generate a structured get query to
  /// get access to user data stored in the backend service
  /// * return the API response
  dynamic userInfo(String token) async {
    return await _http
        .makeGetRequest('users', headers: {'Authorization': 'Bearer $token'});
  }

  /// Is an asyncronous function used to generate a structured get query to
  /// get access to permissions data stored in the backend service
  /// * return the API response
  dynamic permissionsInfo(String token) async {
    return await _http.makeGetRequest('admin/permissions',
        headers: {'Authorization': 'Bearer $token'});
  }

  /// Is an asyncronous function used to generate a structured get query to
  /// get access to a place data stored in the backend service
  /// * retrun the API response
  dynamic placeInfo(String token, String id) async {
    return await _http.makeGetRequest('admin/places/$id',
        headers: {'Authorization': 'Bearer $token'});
  }

  /// Is an asyncronous function used to generate a structures get query to
  /// get access to guest data stored in the backend service
  /// * return the API response
  dynamic guestInfo(String token, String id) async {
    return await _http.makeGetRequest('permissions/access/$id',
        headers: {'Authorization': 'Bearer $token'});
  }

  /// Is an asyncronous function used to generate a structured get query to
  /// get access to all places data stored in the backend service
  /// * retrun the API response
  dynamic placesInfo(String token) async {
    return await _http.makeGetRequest('admin/places',
        headers: {'Authorization': 'Bearer $token'});
  }

  /// Is an asyncronous function used to generate a structured get query to
  /// get access to all guests data stored in the backend service
  /// * return the API response
  dynamic guestsInfo(String token) async {
    return await _http.makeGetRequest('admin/guests',
        headers: {'Authorization': 'Bearer $token'});
  }

  /// Is an asyncronous function used to generate a structured get query to
  /// get access to all guests occupation logged in a place in the backend
  /// service
  /// * return the API response
  dynamic occupationInfo(String token, String id) async {
    return await _http.makeGetRequest('admin/places/$id/current_guests',
        headers: {'Authorization': 'Bearer $token'});
  }

  /// Is an asyncronous function used to generate a structured get query to
  /// get access to user data stored in the backend service
  /// * return the API response
  dynamic usersInfo(String token) async {
    return await _http.makeGetRequest('admin/users',
        headers: {'Authorization': 'Bearer $token'});
  }

  dynamic updateUser(String token, String id, String newId, String newName,
      String newRole, String newPlace) async {
    return await _http.makePutRequest('admin/users/$id',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'user': {
            'id': newId,
            'name': newName,
            'role': newRole,
            'place_id': newPlace
          }
        }));
  }

  dynamic createUser(
      String token, String id, String name, String role, String placeId) async {
    return await _http.makePostRequest('admin/users',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'user': {'id': id, 'name': name, 'role': role, 'place_id': placeId}
        }));
  }

  dynamic updateGuest(
      String token, String id, String newId, String newName) async {
    return await _http.makePutRequest('admin/guests/$id',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'guest': {'id': newId, 'name': newName}
        }));
  }

  dynamic createGuest(String token, String id, String name) async {
    return await _http.makePostRequest('admin/guests',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'guest': {'id': id, 'name': name}
        }));
  }

  dynamic deleteGuest(String token, String id) async {
    return await _http.makeDeleteRequest('admin/guests/$id',
        headers: {'Authorization': 'Bearer $token'});
  }

  dynamic deleteUser(String token, String id) async {
    return await _http.makeDeleteRequest('admin/users/$id',
        headers: {'Authorization': 'Bearer $token'});
  }

  dynamic deletePlace(String token, String id) async {
    return await _http.makeDeleteRequest('admin/places/$id',
        headers: {'Authorization': 'Bearer $token'});
  }

  dynamic createPlace(String token, String name) async {
    return await _http.makePostRequest('admin/places',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'place': {'name': name}
        }));
  }

  dynamic updatePlace(String token, String id, String name) async {
    return await _http.makePutRequest('admin/places/$id',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'place': {'name': name}
        }));
  }

  dynamic createPermission(String token, String placeId, String guestId,
      String startDay, String endDay, String startHour, String endHour) async {
    return await _http.makePostRequest('admin/permissions',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'permission': {
            'place_id': placeId,
            'guest_id': guestId,
            'start_day': startDay,
            'end_day': endDay,
            'start_time': startHour,
            'end_time': endHour
          }
        }));
  }

  dynamic updatePermission(
      String token,
      String id,
      String placeId,
      String guestId,
      String startDay,
      String endDay,
      String startHour,
      String endHour) async {
    return await _http.makePutRequest('admin/permissions/$id',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'permission': {
            'place_id': placeId,
            'guest_id': guestId,
            'start_day': startDay,
            'end_day': endDay,
            'start_time': startHour,
            'end_time': endHour
          }
        }));
  }

  dynamic deletePermission(String token, String id) async {
    return await _http.makeDeleteRequest('admin/permissions/$id',
        headers: {'Authorization': 'Bearer $token'});
  }
}

/// The private class _HttpRequests is used to communicate with the API endpoints
/// to send querys and get data from the backend service
class _HttpRequests {
  //TODO: Use environment variables or configuration files.
  String urlBase = 'http://192.168.0.10:3000/';

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
    var response = await http.put(uri, headers: headers, body: body);
    var returnValue = jsonDecode(response.body);

    returnValue['statusCode'] = response.statusCode;

    return returnValue;
  }

  /// Is an asyncronous function used to generate a delete request to the API
  /// endpoints with a given route, body and headers
  /// * return the API response
  dynamic makeDeleteRequest(route, {body, headers}) async {
    var uri = Uri.parse(urlBase + route);
    var response = await http.delete(uri, headers: headers, body: body);
    var returnValue = jsonDecode(response.body);

    returnValue['statusCode'] = response.statusCode;

    return returnValue;
  }
}
