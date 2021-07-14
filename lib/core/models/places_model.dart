/// The class PlacesModel contains the data needed for the places form
class PlacesModel {
  late String _name, _occupation;

  PlacesModel({required String name, required String occupation}) {
    this._name = name;
    this._occupation = occupation;
  }

  /// The function getName return the stored place name
  /// * return the place name
  String getName() {
    return this._name;
  }

  /// The function getOccupation return the stored place occupation
  /// * return the place occupation
  String getOccupation() {
    return this._occupation;
  }
}
