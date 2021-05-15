// Flutter imports
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:go_mobile/widgets/nft_reading_widget.dart';

// Project imports
import '../util/colors.dart' as appColors;
import '../util/icons.dart' as appIcons;

class NFCView extends StatefulWidget {
  @override
  _NFCViewState createState() => _NFCViewState();
}

class _NFCViewState extends State<NFCView> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackArrowPressed,
        child: FutureBuilder<bool>(
            future: NfcManager.instance.isAvailable(),
            builder: (context, ss) =>
                ss.data != true ? ncfNotFound() : loadAnimation()));
  }

  Future<bool> _onBackArrowPressed() {
    Navigator.pop(context);
    return null;
  }

  Widget loadAnimation() {
    return NfcAnimationWidget();
  }

  Widget ncfNotFound() {
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
                Icons.warning,
                color: Colors.white,
                size: 150,
              ),
            ),
          ]
        ),
        Positioned(
          bottom: 30,          
          child: Text(
            'NFC sensor not found',
            style: TextStyle(color: appColors.white, fontSize: 40),
            ),
        ),
      ],
    );
  }
}
