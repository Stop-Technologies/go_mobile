// Flutter imports
import 'package:flutter_svg/flutter_svg.dart';

// Project imports
import 'package:flutter/material.dart';
import '../util/colors.dart' as appColors;
import '../util/icons.dart' as appIcons;

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: appColors.darkBlue),
        ),
        Positioned(
          top: 30,
          child: SvgPicture.asset(
            appIcons.goIcon,
            color: appColors.white,
            width: 30,
          ),          
        ),     
        Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: Icon(
                Icons.settings,
                color: Colors.white,
                size: 150,
              ),
            ),
          ]
        ),
        Positioned(
          bottom: 30,          
          child: Text(
            'Version 1.0',
            style: TextStyle(color: appColors.white, fontSize: 40),
            ),
        ),
      ],
    );    
  }
}