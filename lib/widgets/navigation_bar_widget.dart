// Flutter imports
import 'package:flutter/material.dart';
import '../views/admin_views/control_view.dart';

// Project imports
import '../core/helpers/Auth_helper.dart';
import '../util/colors.dart' as appColors;
import '../util/icons.dart' as appIcons;
import '../views/settings_view.dart';
import '../views/profile_view.dart';
import '../views/nfc_view.dart';

// ignore: must_be_immutable
class NavigationBar extends StatefulWidget {
  late String id, name;
  late bool admin;

  NavigationBar({required this.id, required this.name, this.admin = false});

  @override
  _NavigationBarState createState() =>
      _NavigationBarState(id: this.id, name: this.name, admin: this.admin);
}

class _NavigationBarState extends State<NavigationBar> {
  List<Widget> _widgetOptions = [];
  AuthHelper helper = AuthHelper();
  late int _selectedIndex = 1;
  String name, id;
  bool admin;

  _NavigationBarState(
      {required this.id, required this.name, required this.admin});

  @override
  Widget build(BuildContext context) {
    if (admin) return buildAdmin();
    return buildNonAdmin();
  }

  Widget buildAdmin() {
    _widgetOptions = <Widget>[
      ProfileView(name: this.name, id: this.id.toString()),
      NFCView(),
      ControlView(),
      SettingsView(),
    ];

    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon:
                      Icon(appIcons.profileBarIcon, color: appColors.textColor),
                  label: 'Perfil'),
              BottomNavigationBarItem(
                  icon: Icon(appIcons.nfcBarIcon), label: 'Escanear'),
              BottomNavigationBarItem(
                  icon: Icon(appIcons.controlBarIcon), label: 'Control'),
              BottomNavigationBarItem(
                  icon: Icon(appIcons.settingsBarIcon), label: 'Configuración'),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTap,
            fixedColor: appColors.darkBlue,
            unselectedItemColor: appColors.textColor,
            showUnselectedLabels: true,
            unselectedLabelStyle: TextStyle(color: appColors.textColor)));
  }

  Widget buildNonAdmin() {
    _widgetOptions = <Widget>[
      ProfileView(name: this.name, id: this.id.toString()),
      NFCView(),
      SettingsView(),
    ];

    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(appIcons.profileBarIcon), label: 'Profile'),
              BottomNavigationBarItem(
                  icon: Icon(appIcons.nfcBarIcon), label: 'Scan'),
              BottomNavigationBarItem(
                  icon: Icon(appIcons.settingsBarIcon), label: 'Settings'),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTap,
            fixedColor: appColors.darkBlue,
            unselectedItemColor: appColors.textColor,
            showUnselectedLabels: true,
            unselectedLabelStyle: TextStyle(color: appColors.textColor)));
  }

  /// The private function _onItemTap is used to change the [_selectedIndex] to
  /// the user actions in the navigation bar
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
