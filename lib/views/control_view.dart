// Flutter imports
import 'package:flutter/material.dart';
import 'package:go_mobile/views/permissions_view.dart';
import 'package:go_mobile/views/places_view.dart';
import 'package:go_mobile/views/users_view.dart';

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
    return Container(
        color: appColors.lightBlue,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: appColors.darkBlue,
                      borderRadius: BorderRadius.circular(30)),
                  child: TextButton(
                      onPressed: _onPlacesPressed,
                      child: Text('Lugares',
                          style: TextStyle(color: appColors.white))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: appColors.darkBlue,
                      borderRadius: BorderRadius.circular(30)),
                  child: TextButton(
                      onPressed: _onPermissionsPressed,
                      child: Text('Permisos',
                          style: TextStyle(color: appColors.white))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: appColors.darkBlue,
                      borderRadius: BorderRadius.circular(30)),
                  child: TextButton(
                      onPressed: _onGuestPressed,
                      child: Text('Invitados',
                          style: TextStyle(color: appColors.white))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 60),
                child: Container(
                  decoration: BoxDecoration(
                      color: appColors.darkBlue,
                      borderRadius: BorderRadius.circular(30)),
                  child: TextButton(
                      onPressed: _onUsersPressed,
                      child: Text('Usuarios',
                          style: TextStyle(color: appColors.white))),
                ),
              )
            ]));
  }

  void _onPlacesPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PlacesView()));
  }

  void _onPermissionsPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PermissionsView()));
  }

  void _onGuestPressed() {}

  void _onUsersPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UsersView()));
  }
}
