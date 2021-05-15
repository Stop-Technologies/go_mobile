// Flutter imports;
import 'package:flutter/material.dart';
import 'package:go_mobile/views/nfc_view.dart';

// Project imports
import '../views/access_view.dart';
import '../views/login_view.dart';
import '../widgets/navigation_bar_widget.dart';
import '../main.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/login': (context) => LoginView(),
  '/nfc-view': (context) => NFCView(),
  '/accesss': (context) => AccessView(access: true, name: "User", id: "123"),
  '/main': (context) => App(),
  '/nav': (context) => NavigationBar()
};
