// Flutter imports
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

// Project imports
import '../widgets/autorize_data_widget.dart';
import '../util/colors.dart' as appColors;
import '../util/icons.dart' as appIcons;

// ignore: must_be_immutable
class AccessView extends StatefulWidget {
  late bool _access;
  late String _name, _id;

  AccessView({required bool access, required String name, required String id}) {
    this._access = access;
    this._name = name;
    this._id = id;
  }

  @override
  _AccessViewState createState() =>
      _AccessViewState(access: this._access, name: this._name, id: this._id);
}

class _AccessViewState extends State<AccessView> {
  late Color _backgroundColor;
  late bool _access;
  late String _name, _id;

  _AccessViewState(
      {required bool access, required String name, required String id}) {
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
    return LayoutBuilder(builder: (context, constraints) {
      Widget layoutColumn;

      if (constraints.maxHeight > 638) {
        layoutColumn = Container(
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
                ]));
      } else {
        layoutColumn = Container(
            decoration: BoxDecoration(color: _backgroundColor),
            child: SingleChildScrollView(
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
                  ]),
            ));
      }

      return Material(
        child: WillPopScope(
          onWillPop: _onBackArrowPressed,
          child: layoutColumn,
        ),
      );
    });
  }

  /// The private function _setValues is used to change the [_backgroundColor]
  /// based in the [_access] value
  void _setValues() {
    if (this._access)
      this._backgroundColor = appColors.green;
    else
      this._backgroundColor = appColors.red;
  }

  /// The private function _onBackArrowPressed is used to pop the widget from
  /// the navigator
  Future<bool> _onBackArrowPressed() {
    Navigator.pop(context);
    return Future(() => false);
  }
}
