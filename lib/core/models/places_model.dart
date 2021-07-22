/// The class PlacesModel contains the data needed for the places form
class PlacesModel {
  late String _id, _name, _occupation;

  PlacesModel(
      {required String id, required String name, required String occupation}) {
    this._id = id;
    this._name = name;
    this._occupation = occupation;
  }

  /// The function getName return the stored place name
  /// * return the place name
  String getName() {
    return this._name;
  }

  /// The function getId return the store place id
  /// * return the palce id
  String getId() {
    return this._id;
  }

  /// The function getOccupation return the stored place occupation
  /// * return the place occupation
  String getOccupation() {
    return this._occupation;
  }
}
