/// The class UsersModel contains the data needed for the guest form
class UsersModel {
  late String _name, _id, _role;
  String? _place, _placeId;

  UsersModel(
      {required String id,
      required String name,
      required String role,
      String? place,
      String? placeId}) {
    this._id = id;
    this._name = name;
    this._role = role;
    this._place = place;
    this._placeId = placeId;
  }

  /// The function getId return the user id
  /// * return the user id
  String getId() {
    return this._id;
  }

  /// The function getName return the user name
  /// * return the user name
  String getName() {
    return this._name;
  }

  /// The function getRole return the user name
  /// * return the user role
  String getRole() {
    return this._role;
  }

  /// The function getPlce return the user designated place
  /// * return the user designated place id or empty string if not exist
  String getPlace() {
    if (this._place != null) return this._place!;
    return '';
  }

  String getPlaceId() {
    if (this._placeId != null) return this._placeId!;
    return '';
  }
}
