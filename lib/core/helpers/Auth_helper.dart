// Flutter imports
import 'package:flutter/material.dart';

// Project imports
import '../../services/backend_access/backend_service.dart';
import '../token_manager.dart';

class AuthHelper extends InheritedWidget {
  TokenManager _tokens = TokenManager();
  BackendService _backend = BackendService();
  String id = "", name = "", role = "";

  AuthHelper({Key? key, required Widget child})
      : super(key: key, child: child) {
    _tokens.loadTokens();
  }

  bool hasTokens() {
    if (_tokens.userToken != null && _tokens.refreshToken != null)
      return true;
    else
      return false;
  }

  Future<bool> logIn(String id, String password) async {
    await _backend.authenticate(id, password).then((value) {
      if (value['statusCode'] != '200') return false;

      _tokens.saveToken(value['access_token'] as String, isUserToken: true);
      _tokens.saveToken(value['refresh_token'] as String, isRefreshToken: true);
      return true;
    });

    return false;
  }

  Future<bool> refreshToken() async {
    await _backend.refreshToken(_tokens.refreshToken).then((value) {
      if (value['statusCode'] != '200') return false;

      _tokens.removeToken(isUserToken: true);
      _tokens.saveToken(value['access_token'] as String, isUserToken: true);
      return true;
    });

    return false;
  }

  Future<bool> logOut() async {
    await _backend.revokeToken(_tokens.userToken).then((value) {
      if (value['statusCode'] != '200') return false;
      return true;
    });

    return false;
  }

  Future<bool> profileInfo() async {
    await _backend.userInfo(_tokens.userToken).then((value) {
      if (value['statusCode'] != '200') return false;

      this.id = value['user']['id'];
      this.name = value['user']['name'];
      this.role = value['user']['role'];
      return true;
    });

    return false;
  }

  static AuthHelper of(BuildContext context) {
    final AuthHelper? result =
        context.dependOnInheritedWidgetOfExactType<AuthHelper>();
    assert(result != null, 'No AuthHelper found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AuthHelper old) => id != old.id;
}
