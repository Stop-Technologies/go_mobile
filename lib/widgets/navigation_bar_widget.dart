// Flutter imports
import 'package:flutter/material.dart';
import 'package:go_mobile/core/helpers/Auth_helper.dart';

// Project imports
import 'package:go_mobile/views/profile_view.dart';
import 'package:go_mobile/views/nfc_view.dart';
import 'package:go_mobile/views/settings_view.dart';

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
  late int _selectedIndex = 0;
  late String name, id;

  _NavigationBarState({required this.id, required this.name});

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.nfc_rounded),
              title: Text('Scan'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
        ));
  }
}
