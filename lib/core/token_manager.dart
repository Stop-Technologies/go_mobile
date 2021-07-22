// Flutter imports
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// The class TokenManager is used to manage the access tokens for oauth 2.0
class TokenManager {
  String userToken = "", refreshToken = "";
  FlutterSecureStorage vault = FlutterSecureStorage();

  /// The function loadTokens is an asyncronous function that use the secure
  /// storage library in order to decrypt the access tokens for oauth 2.0
  /// * return false if one of the access tokens failed loading
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

  /// The function saveToken is an asyncronous function that use the secure
  /// storage library in order to encrypt and save an access token for oauth 2.0
  /// * [token] is the token to be stored
  /// * [isUserToken] is a boolean to save as user token
  /// * [isRefreshToken] is a boolean to save as refresh token
  /// * return false if both descriptors have the same value
  Future<bool> saveToken(String token,
      {bool isUserToken = false, bool isRefreshToken = false}) async {
    if ((isUserToken && isRefreshToken) || (!isUserToken && !isRefreshToken))
      return false;

    if (isUserToken) await vault.write(key: 'userToken', value: token);
    if (isRefreshToken) await vault.write(key: 'refreshToken', value: token);
    return true;
  }

  /// The function removeToken is an asyncronous function that use the secure
  /// storage library in order to remove a saved access token for oauth 2.0
  /// * [isUserToken] is a boolean to delete the user token
  /// * [isRefreshToken] is a boolean to delete the refresh token
  /// * use both descriptors as true to delete both access tokens
  Future<void> removeToken(
      {bool isUserToken = false, bool isRefreshToken = false}) async {
    if (isUserToken) await vault.delete(key: 'userToken');
    if (isRefreshToken) await vault.delete(key: 'refreshToken');
  }
}
