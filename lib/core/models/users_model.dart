/// The class UsersModel contains the data needed for the guest form
class UsersModel {
  late String _name, _id, _role;

  UsersModel({required String id, required String name, required String role}) {
    this._id = id;
    this._name = name;
    this._role = role;
  }

  /// The function getId return the guest id
  /// * return the guest id
  String getId() {
    return this._id;
  }

  /// The function getName return the guest name
  /// * return the guest name
  String getName() {
    return this._name;
  }

  /// The function getRole return the guest name
  /// * return the guest role
  String getRole() {
    return this._role;
  }
}
