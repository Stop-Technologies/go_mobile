// Flutter imports
import 'package:flutter/material.dart';

// Project imports
import '../../../util/colors.dart' as appColors;

class PermissionEditView extends StatefulWidget {
  const PermissionEditView({Key? key}) : super(key: key);

  @override
  _PermissionEditViewState createState() => _PermissionEditViewState();
}

class _PermissionEditViewState extends State<PermissionEditView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackButtonPressed,
        child: Material(
            color: appColors.lightBlue,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [],
                ))));
  }

  Future<bool> _onBackButtonPressed() async {
    Navigator.pop(context);
    return false;
  }
}
