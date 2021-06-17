// Flutter imports
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  String userToken = "", refreshToken = "";
  FlutterSecureStorage vault = FlutterSecureStorage();

  Future<bool> loadTokens() async {
    userToken = await vault.read(key: 'userToken').then((value) {
      if (value == null) return "";
      return value;
    });

    refreshToken = await vault.read(key: 'refreshToken').then((value) {
      if (value == null) return "";
      return value;
    });

    if (userToken == "" || refreshToken == "") return false;

    return true;
  }

  Future<void> saveToken(String token,
      {bool isUserToken = false, bool isRefreshToken = false}) async {
    if (isUserToken && isRefreshToken) return;
    if (isUserToken) await vault.write(key: 'userToken', value: token);
    if (isRefreshToken) await vault.write(key: 'refreshToken', value: token);
  }

  Future<void> removeToken(
      {bool isUserToken = false, bool isRefreshToken = false}) async {
    if (isUserToken) await vault.delete(key: 'userToken');
    if (isRefreshToken) await vault.delete(key: 'refreshToken');
  }
}
