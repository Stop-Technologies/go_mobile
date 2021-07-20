// Project import
import '../../services/backend_access/backend_service.dart';
import '../models/permissions_model.dart';
import '../models/places_model.dart';
import '../models/users_model.dart';
import '../token_manager.dart';

// ignore: must_be_immutable
/// The class AuthHelper is used to manage all the querys to the backend API
class AuthHelper {
  TokenManager _tokens = TokenManager();
  BackendService _backend = BackendService();
  String id = "", name = "", role = "", guestName = "";
  bool access = false;

  AuthHelper() {
    _tokens.loadTokens();
  }

  /// Is an asynchronous function used to check if the access tokens are loaded
  /// * return false if the tokens are not loaded
  Future<bool> hasTokens() async {
    await _tokens.loadTokens();

    if (_tokens.userToken != "" && _tokens.refreshToken != "")
      return true;
    else
      return false;
  }

  /// Is an asynchronous function used to send a query to the backend API and
  /// save the access tokens if the login was correct
  /// * return false if login was incorrect
  Future<bool> logIn(String id, String password) async {
    return await _backend.authenticate(id, password).then((value) async {
      if (value['statusCode'] as int != 200) {
        return false;
      }

      await _tokens.saveToken(value['access_token'] as String,
          isUserToken: true);
      await _tokens.saveToken(value['refresh_token'] as String,
          isRefreshToken: true);
      return true;
    });
  }

  /// Is an asynchronous function used to refresh the access tokens when user
  /// token has expired using the refresh token and save the new access tokens
  /// * return false if refresh was incorrect
  Future<bool> refreshToken() async {
    return await _backend
        .refreshToken(_tokens.refreshToken)
        .then((value) async {
      if (value['statusCode'] as int != 200) return false;

      await _tokens.saveToken(value['access_token'] as String,
          isUserToken: true);
      await _tokens.saveToken(value['refresh_token'] as String,
          isRefreshToken: true);

      return true;
    });
  }

  /// Is an asynchronous function used to revoke the access tokens from the
  /// backend service and delete the tokens from the secure storage
  /// * return false if logout was incorrect
  Future<bool> logOut() async {
    if (!await hasTokens()) return false;

    return await _backend.revokeToken(_tokens.userToken).then((value) async {
      if (value['statusCode'] as int != 200) return false;

      await removeTokens();
      return true;
    });
  }

  /// Is an asynchronous function used to get the user data from the backend
  /// service to display it into the app
  /// * return false if the query was incorrect
  Future<bool> profileInfo() async {
    if (!await hasTokens()) return false;

    return await _backend.userInfo(_tokens.userToken).then((value) {
      if (value['statusCode'] as int != 200) return false;

      this.id = value['user']['id'];
      this.name = value['user']['name'];
      this.role = value['user']['role'];

      return true;
    });
  }

  /// Is an asynchronous function used to get a guest data from the backend
  /// service to check if it has access or not
  /// * return false if the query was incorrect
  Future<bool> guestInfo(String id) async {
    if (!await hasTokens()) return false;

    return await _backend.guestInfo(_tokens.userToken, id).then((value) {
      if (value['statusCode'] as int != 200) return false;

      this.access = value['access'];
      this.guestName = value['name'];

      return true;
    });
  }

  /// Is an asynchronous function used to get the permissions data from the
  /// backend to display in the app
  /// * return the organiced list of PermissionModels to display
  Future<List<PermissionModel>> permissionInfo() async {
    if (!await hasTokens()) return [];

    List<PermissionModel> data = [];
    List result = [], places = [], guests = [];

    // Get all permissions
    await _backend.permissionsInfo(_tokens.userToken).then((value) {
      if (value['statusCode'] as int != 200) return [];

      result = value['permissions'] as List;
    });

    // Get all places
    await _backend.placesInfo(_tokens.userToken).then((value) {
      if (value['statusCode'] as int != 200) return null;

      places = value['places'] as List;
    });

    // Get all guests
    await _backend.guestsInfo(_tokens.userToken).then((value) {
      if (value['statusCode'] as int != 200) return null;

      guests = value['guests'] as List;
    });

    // Save all permissions into data list
    for (dynamic index in result) {
      String place = "", guest = "";

      // Get place name by id
      for (dynamic dataIndex in places) {
        if (dataIndex['id'] == index['place_id']) {
          place = dataIndex['name'];
          break;
        }
      }

      // Get guest name by id
      for (dynamic dataIndex in guests) {
        if (dataIndex['id'] == index['guest_id']) {
          guest = dataIndex['name'];
          break;
        }
      }

      data.add(new PermissionModel(
          place: place,
          guest: guest,
          startingDay: '${index['start_day']}',
          finishingDay: '${index['end_day']}',
          startingHour: '${index['start_time']}',
          finishingHour: '${index['end_time']}'));
    }

    return data;
  }

  /// Is an asynchronous function used to get the places data from the backend
  /// service to display in the app
  /// * return the organiced list of PlacesModel to display
  Future<List<PlacesModel>> placesInfo() async {
    if (!await hasTokens()) return [];

    List<PlacesModel> data = [];
    List places = [];

    // Get all places
    await _backend.placesInfo(_tokens.userToken).then((value) {
      if (value['statusCode'] as int != 200) return null;

      places = value['places'] as List;
    });

    // Save all places into data list
    for (dynamic index in places) {
      String occupation = '0';

      await _backend
          .occupationInfo(_tokens.userToken, index['id'].toString())
          .then((value) {
        if (value['statusCode'] as int != 200) return null;

        return occupation = value['currentUsers'].toString();
      });

      data.add(new PlacesModel(
          id: index['id'].toString(),
          name: index['name'],
          occupation: occupation));
    }

    return data;
  }

  /// Is an asynchronous function used to get the users data from the backend
  /// service to display in the app
  /// * return the organiced list of UsersModel to display
  Future<List<UsersModel>> usersInfo() async {
    if (!await hasTokens()) return [];

    List<UsersModel> data = [];
    List response = [], places = [];

    await _backend.usersInfo(_tokens.userToken).then((value) {
      if (value['statusCode'] as int != 200) return null;

      response = value['users'] as List;
    });

    await _backend.placesInfo(_tokens.userToken).then((value) {
      if (value['statusCode'] as int != 200) return null;

      places = value['places'] as List;
    });

    for (dynamic index in response) {
      String place = index['place_id'].toString();

      for (dynamic placeIndex in places) {
        if (place.compareTo(placeIndex['id'].toString()) == 0) {
          place = placeIndex['name'];
        }
      }

      data.add(new UsersModel(
          id: index['id'],
          name: index['name'],
          role: index['role'],
          place: place,
          place_id: index['place_id'].toString()));

      print(index['place_id'].toString() + '<==');
    }

    return data;
  }

  /// Is an asynchronous function used to get the guests data from the backend
  /// service to display in the app
  /// * return the organiced list of UsersModel to display
  Future<List<UsersModel>> guestsInfo() async {
    if (!await hasTokens()) return [];

    List<UsersModel> data = [];
    List response = [];

    await _backend.guestsInfo(_tokens.userToken).then((value) {
      if (value['statusCode'] as int != 200) return null;

      response = value['guests'] as List;
      return null;
    });

    for (dynamic index in response) {
      data.add(
          new UsersModel(id: index['id'], name: index['name'], role: 'guest'));
    }

    return data;
  }

  /// Is an asynchronous function used to udpate the user info in the backend
  /// service
  /// * return false if the query was incorrect
  Future<bool> updateUser(String id, String newId, String newName,
      String newRole, String newPlace) async {
    return await _backend
        .updateUser(_tokens.userToken, id, id, newName, newRole, newPlace)
        .then((value) {
      if (value['statusCode'] as int != 200) return false;

      return true;
    });
  }

  /// Is an asynchronous function used to create a new user in the backend service
  /// * return false if the query was incorrect
  Future<bool> createUser(
      String id, String name, String role, String placeId) async {
    return await _backend
        .createUser(_tokens.userToken, id, name, role, placeId)
        .then((value) {
      if (value['statusCode'] as int != 200) return false;

      return true;
    });
  }

  /// Is an asynchronous function used to udpate the guest info in the backend
  /// service
  /// * return false if the query was incorrect
  Future<bool> updateGuest(String id, String newId, String newName) async {
    return await _backend
        .updateGuest(_tokens.userToken, id, newId, newName)
        .then((value) {
      if (value['statusCode'] as int != 200) return false;

      return true;
    });
  }

  /// Is an asynchronous function used to create a new guest in the backend service
  /// * return false if the query was incorrect
  Future<bool> createGuest(String id, String name) async {
    return await _backend
        .createGuest(_tokens.userToken, id, name)
        .then((value) {
      if (value['statusCode'] as int != 200) return false;

      return true;
    });
  }

  Future<bool> deleteGuest(String id) async {
    return await _backend.deleteGuest(_tokens.userToken, id).then((value) {
      if (value['statusCode'] as int != 200) return false;

      return true;
    });
  }

  Future<bool> deleteUser(String id) async {
    return await _backend.deleteUser(_tokens.userToken, id).then((value) {
      if (value['statusCode'] as int != 200) return false;

      return true;
    });
  }

  Future<bool> deletePlace(String id) async {
    return await _backend.deletePlace(_tokens.userToken, id).then((value) {
      if (value['statusCode'] as int != 200) return false;

      return true;
    });
  }

  Future<bool> createPlace(String name) async {
    return await _backend.createPlace(_tokens.userToken, name).then((value) {
      if (value['statusCode'] as int != 200) return false;

      return true;
    });
  }

  Future<bool> updatePlace(String id, String name) async {
    return await _backend
        .updatePlace(_tokens.userToken, id, name)
        .then((value) {
      if (value['statusCode'] as int != 200) return false;

      return true;
    });
  }

  /// Is an asynchronous function used to delete the access tokens from the
  /// secure storage
  Future<void> removeTokens() async {
    await _tokens.removeToken(isUserToken: true, isRefreshToken: true);
  }
}
