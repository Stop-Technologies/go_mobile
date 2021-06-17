// Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_mobile/widgets/profile_data_widget.dart';

// Project imports
import '../util/colors.dart' as appColors;
import '../util/icons.dart' as appIcons;

// ignore: must_be_immutable
class ProfileView extends StatefulWidget {
  late String _name, _id;

  ProfileView({required String name, required String id}) {
    this._name = name;
    this._id = id;
  }

  @override
  _ProfileViewState createState() =>
      _ProfileViewState(name: this._name, id: this._id);
}

class _ProfileViewState extends State<ProfileView> {
  late Color _backgroundColor;
  late String name, id;

  _ProfileViewState({required this.name, required this.id});

  @override
  void initState() {
    _setValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      Widget layoutColumn;

      if (constraints.maxHeight > 500) {
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
                  ProfileData(name: name, id: id),
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
                    ProfileData(name: name, id: id),
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

  void _setValues() {
    this._backgroundColor = appColors.lightBlue;
  }

  Future<bool> _onBackArrowPressed() {
    Navigator.pop(context);
    return Future(() => false);
  }
}
