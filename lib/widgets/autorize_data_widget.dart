// Flutter imports
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

// Project imports
import '../util/colors.dart' as appColors;
import '../util/icons.dart' as appIcons;

// ignore: must_be_immutable
class AutorizeData extends StatelessWidget {
  late Color _backgroundColor;
  late String _accessText, _name, _id, _iconName;
  late bool _access;

  AutorizeData(
      {required bool access, required String name, required String id}) {
    this._access = access;
    this._name = name;
    this._id = id;
  }

  @override
  Widget build(BuildContext context) {
    _setValues();

    return Container(
        decoration: BoxDecoration(
            color: appColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35))),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 30, 30, 1),
                  child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: appColors.lightGrey,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            _name,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ))),
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 2, 30, 1),
                  child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: appColors.lightGrey,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            _id,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ))),
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 18, 30, 30),
                  child: Container(
                      decoration: BoxDecoration(
                          color: _backgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(_accessText,
                                    style: TextStyle(
                                        color: appColors.white, fontSize: 30)),
                              ),
                            ),
                            SizedBox(height: 20),
                            SvgPicture.asset(_iconName,
                                width: 140, color: appColors.white),
                            SizedBox(height: 50)
                          ])))
            ]));
  }

  /// The private function _setValues is used to change the [_backgroundColor],
  /// [_accessText] and [_iconName] for the access card
  void _setValues() {
    if (this._access) {
      this._backgroundColor = appColors.green;
      this._accessText = 'Acceso Permitido';
      this._iconName = appIcons.allowedIcon;
    } else {
      this._backgroundColor = appColors.red;
      this._accessText = 'Acceso Denegadod';
      this._iconName = appIcons.deniedIcon;
    }
  }
}
