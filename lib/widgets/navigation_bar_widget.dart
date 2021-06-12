// Flutter imports
import 'package:flutter/material.dart';
import 'package:go_mobile/services/backend_access/backend_service.dart';

// Project imports
import 'package:go_mobile/views/profile_view.dart';
import 'package:go_mobile/views/nfc_view.dart';
import 'package:go_mobile/views/settings_view.dart';

// ignore: must_be_immutable
class NavigationBar extends StatefulWidget {
  int? id = 0;
  String? name = "";

  NavigationBar({this.id, this.name});

  @override
  _NavigationBarState createState() =>
      _NavigationBarState(id: this.id!, name: this.name!);
}

class _NavigationBarState extends State<NavigationBar> {
  List<Widget> _widgetOptions = [];
  late int _selectedIndex = 0, id;
  late String name;

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

  Future<String> getUserInfo(id) async {
    var service = BackendService();

    service.userInfo(id).then((result) {
      if (result['error'] == null) {
        return result['user_name'];
      } else {
        print('Se hallo un error en NavigationBar Widget');
        return 'Unknown';
      }
    });

    return 'Unknown';
  }
}
