// Fluter imports
import 'package:flutter/material.dart';

// Project imports
import '../util/colors.dart' as appColors;

class PlaceWidget extends StatefulWidget {
  late String _name, _occupation;

  PlaceWidget({Key? key, required String name, required String occupation})
      : super(key: key) {
    this._name = name;
    this._occupation = occupation;
  }

  @override
  _PlaceWidgetState createState() =>
      _PlaceWidgetState(name: this._name, occupation: this._occupation);
}

class _PlaceWidgetState extends State<PlaceWidget> {
  String name, occupation;

  _PlaceWidgetState({required this.name, required this.occupation});

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
                                child: Text(occupation,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: appColors.textColor,
                                        fontSize: 20))))))
              ],
            )));
  }
}
