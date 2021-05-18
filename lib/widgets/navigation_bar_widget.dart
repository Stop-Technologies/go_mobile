// Flutter imports
import 'package:flutter/material.dart';
import 'package:go_mobile/core/helpers/userInfo.dart';
import 'package:go_mobile/services/backend_access/backend_service.dart';

// Project imports
import 'package:go_mobile/views/profile_view.dart';
import 'package:go_mobile/views/nfc_view.dart';
import 'package:go_mobile/views/settings_view.dart';

class NavigationBar extends StatefulWidget {
  int id;

  NavigationBar({this.id});

  @override
  _NavigationBarState createState() => _NavigationBarState(id: this.id);
}

class _NavigationBarState extends State<NavigationBar> {
  List<Widget> _widgetOptions;
  int _selectedIndex = 0, id;
  String name = 'Unknown';

  _NavigationBarState({this.id});

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    getUserInfo(id);

    _widgetOptions = <Widget>[
      ProfileView(name: this.name, id: this.id.toString()),
      NFCView(),
      SettingsView(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

  void getUserInfo(id) {
    var service = BackendService();

    service.userInfo(id).then((result) {
      if (result['error'] == null) {
        this.name = result['user_name'];
      }
    });
  }
}
