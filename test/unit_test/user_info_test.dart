import 'package:go_mobile/core/helpers/Auth_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String goodId = '2837087901';

  group('All the user info should work fine when', () {
    // Arrange
    final AuthHelper helper = AuthHelper();

    test('getting user info from backend', () async {
      // Arrange
      bool queryValue;

      // Act
      queryValue =
          await helper.logIn(goodId, 'password').then((value) => value);

      // Assert
      expect(queryValue, true);
    });
  });
}
