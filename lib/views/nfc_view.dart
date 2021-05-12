// Flutter imports
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:go_mobile/widgets/nft_reading_widget.dart';
import 'package:go_mobile/widgets/nft_pause_widget.dart';

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
                ss.data == true ? ncfNotFound() : loadAnimation()));
  }

  Future<bool> _onBackArrowPressed() {
    Navigator.pop(context);
    return null;
  }

  Widget loadAnimation() {
    return NfcAnimationWidgetPause();
  }

  Widget ncfNotFound() {
    return Center(child: Text('No se ha encontrado ningún sensor NFC'));
  }
}
