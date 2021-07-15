// Flutter imports
import 'dart:ui';

import 'package:flutter/material.dart';

// Project imports
import '../util/colors.dart' as appColors;

class PermissionWidget extends StatefulWidget {
  late String _place, _guest, _days, _hours;

  PermissionWidget(
      {Key? key,
      required String place,
      required String guest,
      required String days,
      required String hours})
      : super(key: key) {
    this._place = place;
    this._guest = guest;
    this._days = days;
    this._hours = hours;
  }

  @override
  _PermissionWidgetState createState() => _PermissionWidgetState(
      place: _place, guest: _guest, days: _days, hours: _hours);
}

class _PermissionWidgetState extends State<PermissionWidget> {
  late String place, guest, days, hours;

  _PermissionWidgetState(
      {required this.place,
      required this.guest,
      required this.days,
      required this.hours});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
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
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(place,
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
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(guest,
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
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(days,
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
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(hours,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: appColors.textColor,
                                        fontSize: 20))))))
              ])),
    );
  }
}
