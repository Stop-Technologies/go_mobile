import 'package:go_mobile/services/backend_access/backend_service.dart';

class UserInfo {
  String name = 'Unknown';
  bool access = false;

  Future<int> getInfo(int id) async {
    var service = BackendService();

    await service.userInfo(id).then((result) {
      if (result['error'] == null) return 1;

      this.name = result['user_name'];
      this.access = result['success'];
    });

    return 0;
  }
}
