// Fluter imports
import 'package:flutter/material.dart';
import 'package:go_mobile/core/helpers/Auth_helper.dart';
import 'package:go_mobile/core/models/places_model.dart';
import 'package:go_mobile/views/admin_views/editors/user_edit_view.dart';

// Project imports
import '../../util/colors.dart' as appColors;

// ignore: must_be_immutable
class UserWidget extends StatefulWidget {
  late String _id, _name, _role, _place_id, place;
  bool havePlace, blockRole, isNew;

  UserWidget(
      {Key? key,
      required String id,
      required String name,
      required String role,
      String place_id = '0',
      String place = '',
      this.havePlace = false,
      this.blockRole = false,
      this.isNew = false})
      : super(key: key) {
    this._id = id;
    this._name = name;
    this._role = role;
    this._place_id = place_id;
    this.place = place;
  }

  @override
  _UserWidgetState createState() => _UserWidgetState(
      id: this._id,
      name: this._name,
      role: this._role,
      place_id: this._place_id,
      place: this.place,
      havePlace: this.havePlace,
      blockRole: this.blockRole,
      isNew: this.isNew);
}

class _UserWidgetState extends State<UserWidget> {
  String id, name, role, place_id, place;
  bool havePlace, blockRole, isNew;
  AuthHelper helper = new AuthHelper();

  _UserWidgetState(
      {required this.id,
      required this.name,
      required this.role,
      this.place_id = '0',
      this.place = '',
      this.havePlace = false,
      this.blockRole = false,
      this.isNew = false});

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
                                  child: Text('id: $id',
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
                                  child: Text('name: $name',
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
                                  child: Text('role: $role',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: appColors.textColor,
                                          fontSize: 20)))))),
                  _setPlace(this.havePlace),
                  SizedBox(height: 13)
                ],
              )),
        ));
  }

  void _onTap() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserEditView(
                id: this.id,
                name: this.name,
                role: this.role,
                place_id: this.place_id,
                havePlace: this.havePlace,
                blockRole: this.blockRole,
                isNew: this.isNew))).then((_) => setState(() {}));
  }

  Widget _setPlace(bool havePlace) {
    if (havePlace)
      return Padding(
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
                      child: Text('place: $place',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: appColors.textColor, fontSize: 20))))));

    return SizedBox(height: 1);
  }
}
