// Fluter imports
import 'package:flutter/material.dart';
import 'package:go_mobile/views/admin_views/editors/place_edit_view.dart';

// Project imports
import '../../util/colors.dart' as appColors;

// ignore: must_be_immutable
class PlaceWidget extends StatefulWidget {
  late String _id, _name, _occupation;

  PlaceWidget(
      {Key? key,
      required String id,
      required String name,
      required String occupation})
      : super(key: key) {
    this._id = id;
    this._name = name;
    this._occupation = occupation;
  }

  @override
  _PlaceWidgetState createState() => _PlaceWidgetState(
      id: this._id, name: this._name, occupation: this._occupation);
}

class _PlaceWidgetState extends State<PlaceWidget> {
  String id, name, occupation;

  _PlaceWidgetState(
      {required this.id, required this.name, required this.occupation});

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
                                  child: Text('nombre: $name',
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
                                  child: Text('ocupación: $occupation',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: appColors.textColor,
                                          fontSize: 20))))))
                ],
              )),
        ));
  }

  void _onTap() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PlaceEditView(id: this.id, name: this.name);
    }));
  }
}
