/// The class PermissionModel contains the data needed for the permission form
class PermissionModel {
  late String _place,
      _guest,
      _startingDay,
      _finishingDay,
      _startingHour,
      _finishingHour;

  PermissionModel(
      {required place,
      required guest,
      required startingDay,
      required finishingDay,
      required startingHour,
      required finishingHour}) {
    this._place = place;
    this._guest = guest;
    this._startingDay = startingDay;
    this._finishingDay = finishingDay;
    this._startingHour = startingHour;
    this._finishingHour = finishingHour;
  }

  /// The function getPlace return the permission place
  /// * return the place name
  String getPlace() {
    return this._place;
  }

  /// The function getGuest return the guest name of the permission
  /// * return the guest name
  String getGuest() {
    return this._guest;
  }

  /// The function getDay return the days of the week where the guest has permission
  /// * return the days of permission
  String getDay() {
    if (this._startingDay.compareTo(this._finishingDay) == 0)
      return _startingDay;

    return '${this._startingDay} » ${this._finishingDay}';
  }

  /// The function getHour return the hour lapse in the day where the guest has permission
  /// * return the hour lapse
  String getHour() {
    return '${this._startingHour} » ${this._finishingHour}';
  }
}
