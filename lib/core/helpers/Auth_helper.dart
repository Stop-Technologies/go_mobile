// Project imports
import '../../services/backend_access/backend_service.dart';
import '../token_manager.dart';

// ignore: must_be_immutable
class AuthHelper {
  TokenManager _tokens = TokenManager();
  BackendService _backend = BackendService();
  String id = "", name = "", role = "";

  AuthHelper() {
    _tokens.loadTokens();
  }

  Future<bool> hasTokens() async {
    await _tokens.loadTokens();

    if (_tokens.userToken != "" && _tokens.refreshToken != "")
      return true;
    else
      return false;
  }

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

  Future<bool> logOut() async {
    if (!await hasTokens()) return false;

    return await _backend.revokeToken(_tokens.userToken).then((value) async {
      if (value['statusCode'] as int != 200) return false;

      await removeTokens();
      return true;
    });
  }

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

  Future<void> removeTokens() async {
    await _tokens.removeToken(isUserToken: true, isRefreshToken: true);
  }
}
