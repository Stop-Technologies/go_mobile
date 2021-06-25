// Flutter imports
import 'package:flutter/material.dart';

// Project imports
import '../core/helpers/Auth_helper.dart';
import '../util/icons.dart' as appIcons;
import '../views/settings_view.dart';
import '../views/profile_view.dart';
import '../views/nfc_view.dart';

// ignore: must_be_immutable
class NavigationBar extends StatefulWidget {
  late String id, name;

  NavigationBar({required this.id, required this.name});

  @override
  _NavigationBarState createState() =>
      _NavigationBarState(id: this.id, name: this.name);
}

class _NavigationBarState extends State<NavigationBar> {
  List<Widget> _widgetOptions = [];
  AuthHelper helper = AuthHelper();
  late int _selectedIndex = 1;
  late String name, id;

  _NavigationBarState({required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
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
              icon: Icon(appIcons.profileBarIcon),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(appIcons.nfcBarIcon),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: Icon(appIcons.settingsBarIcon),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
        ));
  }

  /// The private function _onItemTap is used to change the [_selectedIndex] to
  /// the user actions in the navigation bar
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
