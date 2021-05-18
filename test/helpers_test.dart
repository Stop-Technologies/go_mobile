import 'package:go_mobile/core/helpers/userInfo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  int goodId = 2837087901;

  group('All the user info should work fine when', () {
    // Arrange
    final UserInfo user = UserInfo();

    test('getting user info from backend', () async {
      // Arrange
      int queryValue;

      // Act
      queryValue = await user.getInfo(goodId).then((value) => value);

      // Assert
      expect(queryValue, 0);
      expect(user.name, 'Alejandro Melo');
      expect(user.access, true);
    });
  });
}
