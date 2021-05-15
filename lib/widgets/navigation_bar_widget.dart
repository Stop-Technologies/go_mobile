// Flutter imports
import 'package:flutter/material.dart';

// Project imports
import 'package:go_mobile/views/profile_view.dart';
import 'package:go_mobile/views/nfc_view.dart';
import 'package:go_mobile/views/settings_view.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    ProfileView(access: true, name: "User", id: "123"),
    NFCView(),
    SettingsView(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
        ),
      bottomNavigationBar: BottomNavigationBar(
        items: const<BottomNavigationBarItem>[
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
      )
    );
  }
}