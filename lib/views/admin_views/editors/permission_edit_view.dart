// Flutter imports
import 'package:flutter/material.dart';

// Project imports
import '../../../util/colors.dart' as appColors;
import '../../../util/icons.dart' as appIcons;

// ignore: must_be_immutable
class PermissionEditView extends StatefulWidget {
  late bool _isNew;

  PermissionEditView({Key? key, bool isNew = false}) : super(key: key) {
    this._isNew = isNew;
  }

  @override
  _PermissionEditViewState createState() =>
      _PermissionEditViewState(isNew: this._isNew);
}

class _PermissionEditViewState extends State<PermissionEditView> {
  bool isNew;

  _PermissionEditViewState({this.isNew = false});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
          child: FloatingActionButton(
              onPressed: _deletePermission,
              backgroundColor: appColors.darkBlue,
              child: Icon(appIcons.removeValue)),
          visible: !isNew),
      body: WillPopScope(
          onWillPop: _onBackButtonPressed,
          child: Material(
              color: appColors.lightBlue,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [],
                  )))),
    );
  }

  Future<bool> _onBackButtonPressed() async {
    Navigator.pop(context);
    return false;
  }

  void _deletePermission() {}
}
