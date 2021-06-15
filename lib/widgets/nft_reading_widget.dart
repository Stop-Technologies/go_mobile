// Flutter imports
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hex/hex.dart';

// Project imports
import '../core/helpers/Auth_helper.dart';
import '../views/access_view.dart';
import '../util/colors.dart' as appColors;
import '../util/icons.dart' as appIcons;

class NfcAnimationWidget extends StatefulWidget {
  @override
  _NfcAnimationWidgetState createState() => _NfcAnimationWidgetState();
}

class _NfcAnimationWidgetState extends State<NfcAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 900),
      vsync: this,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) _controller.reverse();
      if (status == AnimationStatus.dismissed) _controller.forward();
    });

    _animation = Tween<double>(begin: 1.0, end: 1.2)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) _controller.reverse();
      if (status == AnimationStatus.dismissed) _controller.forward();
    });

    _controller.forward();

    readNfc();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: appColors.darkBlue),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: SvgPicture.asset(
              appIcons.goIcon,
              color: appColors.white,
              width: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ScaleTransition(
              scale: _animation,
              child: SvgPicture.asset(
                appIcons.nfcIcon,
                color: appColors.white,
                width: 150.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void readNfc() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      AuthHelper helper = AuthHelper();
      int id = extractId(tag);

      await helper.guestInfo(id.toString()).then((value) {
        if (value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AccessView(
                      access: helper.access,
                      name: helper.guestName,
                      id: id.toString())));
        } else {
          errorPopup('Se produjo un error al leer la tarjeta inteligente');
        }
      });
    });
  }

  int extractId(NfcTag tag) {
    String idString = tag.data['nfca']['identifier']
        .toString(); // Get identifier from nfc tag

    List<String> idComponents = idString
        .substring(1, idString.length - 1)
        .split(', '); // Dividing identifier components

    int id = int.parse(
        HEX.encode([
          int.parse(idComponents[3]),
          int.parse(idComponents[2]),
          int.parse(idComponents[1]),
          int.parse(idComponents[0])
        ]),
        radix: 16); // Transforming the components to the correct id

    return id;
  }

  void errorPopup(String message) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Error'),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'))
              ],
            ));
  }
}
