// Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_mobile/widgets/autorize_data_widget.dart';

// Project imports
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
                    padding: const EdgeInsets.only(top: 30),
                    child: SvgPicture.asset(appIcons.goIcon,
                        width: 30, color: appColors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 30),
                    child: SvgPicture.asset(appIcons.profileIcon, width: 100),
                  ),
                  AutorizeData(access: _access, name: _name, id: _id)
                ])),
      ),
    );
  }

  void _setValues() {
    if (this._access)
      this._backgroundColor = appColors.green;
    else
      this._backgroundColor = appColors.red;
  }

  Future<bool> _onBackArrowPressed() {
    Navigator.pop(context);
    return null;
  }
}
