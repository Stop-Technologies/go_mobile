// Flutter imports
import 'package:flutter/material.dart';

// Project imports
import '../../views/admin_views/editors/permission_edit_view.dart';
import '../../util/colors.dart' as appColors;

// ignore: must_be_immutable
class PermissionWidget extends StatefulWidget {
  late String? _id, _placeId, _place, _guestId, _guest, _days, _hours;

  PermissionWidget(
      {Key? key,
      String? id,
      String? placeId,
      required String? place,
      String? guestId,
      required String? guest,
      required String? days,
      required String? hours})
      : super(key: key) {
    this._id = id;
    this._placeId = placeId;
    this._place = place;
    this._guestId = guestId;
    this._guest = guest;
    this._days = days;
    this._hours = hours;
  }

  @override
  _PermissionWidgetState createState() => _PermissionWidgetState(
      id: _id,
      placeId: _placeId,
      place: _place,
      guestId: _guestId,
      guest: _guest,
      days: _days,
      hours: _hours);
}

class _PermissionWidgetState extends State<PermissionWidget> {
  late String? id, placeId, place, guestId, guest, days, hours;

  _PermissionWidgetState(
      {this.id,
      this.placeId,
      this.place,
      this.guestId,
      this.guest,
      this.days,
      this.hours});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: InkWell(
        onTap: _onTap,
        child: Container(
            decoration: BoxDecoration(
                color: appColors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 2),
                      child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: appColors.lightGrey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text('lugar: ${place!}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: appColors.textColor,
                                          fontSize: 20)))))),
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 2, 15, 2),
                      child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: appColors.lightGrey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text('invitado: ${guest!}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: appColors.textColor,
                                          fontSize: 20)))))),
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 2, 15, 2),
                      child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: appColors.lightGrey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text('dias: ${days!}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: appColors.textColor,
                                          fontSize: 20)))))),
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 2, 15, 15),
                      child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: appColors.lightGrey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text('horas: ${hours!}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: appColors.textColor,
                                          fontSize: 20))))))
                ])),
      ),
    );
  }

  void _onTap() {
    String startDay, endDay, startTime, endTime;
    List<String> weekdays = this.days!.split(' » ');
    List<String> times = this.hours!.split(' » ');

    if (weekdays.length < 2) {
      startDay = weekdays.elementAt(0);
      endDay = weekdays.elementAt(0);
    } else {
      startDay = weekdays.elementAt(0);
      endDay = weekdays.elementAt(1);
    }

    print('$startDay - $endDay');

    startTime = times.elementAt(0);
    endTime = times.elementAt(1);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PermissionEditView(
                id: this.id,
                placeId: this.placeId,
                guestId: this.guestId,
                startDay: startDay,
                endDay: endDay,
                startTime: startTime,
                endTime: endTime)));
  }
}
