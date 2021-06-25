// Project imports
import '../../services/backend_access/backend_service.dart';
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

  /// Is an asyncronous function used to check if the access tokens are loaded
  /// * return false if the tokens are not loaded
  Future<bool> hasTokens() async {
    await _tokens.loadTokens();

    if (_tokens.userToken != "" && _tokens.refreshToken != "")
      return true;
    else
      return false;
  }

  /// Is an asyncronous function used to send a query to the backend API and
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

  /// Is an asyncronous function used to refresh the access tokens when user
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

  /// Is an asyncronous function used to revoke the access tokens from the
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

  /// Is an asyncronous function used to get the user data from the backend
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

  /// Is an asyncronous function used to get a guest data from the backend
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

  /// Is an asyncronous function used to delete the access tokens from the
  /// secure storage
  Future<void> removeTokens() async {
    await _tokens.removeToken(isUserToken: true, isRefreshToken: true);
  }
}
