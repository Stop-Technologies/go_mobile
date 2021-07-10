// Flutter imports
import 'package:flutter/material.dart';

// Project imports
import '../util/colors.dart' as appColors;

class ControlView extends StatefulWidget {
  const ControlView({Key? key}) : super(key: key);

  @override
  _ControlViewState createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
  @override
  Widget build(BuildContext context) {
    return Container(color: appColors.lightBlue);
  }
}
