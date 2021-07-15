// Fluter imports
import 'package:flutter/material.dart';

// Project imports
import '../util/colors.dart' as appColors;

class UserWidget extends StatefulWidget {
  late String _id, _name, _role;

  UserWidget(
      {Key? key,
      required String id,
      required String name,
      required String role})
      : super(key: key) {
    this._id = id;
    this._name = name;
    this._role = role;
  }

  @override
  _UserWidgetState createState() =>
      _UserWidgetState(id: this._id, name: this._name, role: this._role);
}

class _UserWidgetState extends State<UserWidget> {
  String id, name, role;

  _UserWidgetState({required this.id, required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Container(
            decoration: BoxDecoration(
                color: appColors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
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
                                child: Text(id,
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
                                child: Text(name,
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
                                child: Text(role,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: appColors.textColor,
                                        fontSize: 20))))))
              ],
            )));
  }
}
