import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../util/colors.dart' as appColors;
import '../util/icons.dart' as appIcons;

// ignore: must_be_immutable
class AccessView extends StatefulWidget {
  bool _access;
  String _name, _id;

  AccessView({bool access = false, String name = "UNKNOWN", String id = "-1"}) {
    this._access = access;
    this._name = name;
    this._id = id;
  }

  @override
  _AccessViewState createState() =>
      _AccessViewState(access: this._access, name: this._name, id: this._id);
}

class _AccessViewState extends State<AccessView> {
  Color _backgroundColor;
  bool _access;
  String _name, _id, _accessText, _iconName;

  _AccessViewState({bool access, String name, String id}) {
    this._access = access;
    this._name = name;
    this._id = id;
  }

  @override
  void initState() {
    _setValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: WillPopScope(
        onWillPop: _onBackArrowPressed,
        child: Container(
            decoration: BoxDecoration(color: _backgroundColor),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SvgPicture.asset(appIcons.goIcon,
                        width: 30, color: appColors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 100),
                    child: SvgPicture.asset(appIcons.profileIcon, width: 100),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: appColors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.all(5), child: Text(_name)),
                            Padding(
                                padding: EdgeInsets.all(5), child: Text(_id)),
                            Padding(
                                padding: EdgeInsets.all(30),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: _backgroundColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Center(
                                            child: Text(_accessText,
                                                style: TextStyle(
                                                    color: appColors.white,
                                                    fontSize: 30)),
                                          ),
                                          SizedBox(height: 20),
                                          SvgPicture.asset(_iconName,
                                              width: 140,
                                              color: appColors.white),
                                          SizedBox(height: 50)
                                        ])))
                          ]))
                ])),
      ),
    );
  }

  void _setValues() {
    if (this._access) {
      this._backgroundColor = appColors.green;
      this._accessText = 'Access Allowed';
      this._iconName = appIcons.allowedIcon;
    } else {
      this._backgroundColor = appColors.red;
      this._accessText = 'Access Denied';
      this._iconName = appIcons.deniedIcon;
    }
  }

  Future<bool> _onBackArrowPressed() {
    Navigator.pop(context);
    return null;
  }
}
