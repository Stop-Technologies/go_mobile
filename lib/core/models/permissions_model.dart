/// The class PermissionModel contains the data needed for the permission form
class PermissionModel {
  late String _id,
      _placeId,
      _place,
      _guestId,
      _guest,
      _startingDay,
      _finishingDay,
      _startingHour,
      _finishingHour;

  PermissionModel(
      {required String id,
      required String placeId,
      required String place,
      required String guestId,
      required String guest,
      required String startingDay,
      required String finishingDay,
      required String startingHour,
      required String finishingHour}) {
    this._id = id;
    this._placeId = placeId;
    this._place = place;
    this._guestId = guestId;
    this._guest = guest;
    this._startingDay = _convertToWeekDay(startingDay);
    this._finishingDay = _convertToWeekDay(finishingDay);
    this._startingHour = startingHour;
    this._finishingHour = finishingHour;
  }

  /// The function getId return the permission id
  /// * return the permission id
  String getId() {
    return this._id;
  }

  /// The function getPlaceId return the permission place id
  /// * return the place id
  String getPlaceId() {
    return this._placeId;
  }

  /// The function getPlace return the permission place
  /// * return the place name
  String getPlace() {
    return this._place;
  }

  /// The function getGuestId return the permission guest id
  /// * return the guest id
  String getGuestId() {
    return this._guestId;
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

  String _convertToWeekDay(String value) {
    switch (value) {
      case '1':
        return 'Lunes';
      case '2':
        return 'Martes';

      case '3':
        return 'Miercoles';

      case '4':
        return 'Jueves';

      case '5':
        return 'Viernes';

      case '6':
        return 'Sabado';

      case '7':
        return 'Domingo';

      default:
        return value;
    }
  }
}
