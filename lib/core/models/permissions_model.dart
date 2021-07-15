import 'package:flutter/material.dart';

/// The class PermissionModel contains the data needed for the permission form
class PermissionModel {
  late String _place,
      _guest,
      _startingDay,
      _finishingDay,
      _startingHour,
      _finishingHour;

  PermissionModel(
      {required String place,
      required String guest,
      required String startingDay,
      required String finishingDay,
      required String startingHour,
      required String finishingHour}) {
    this._place = place;
    this._guest = guest;
    this._startingDay = _convertToWeekDay(startingDay);
    this._finishingDay = _convertToWeekDay(finishingDay);
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
