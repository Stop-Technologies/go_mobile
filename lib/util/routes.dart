//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:go_mobile/views/nfc_view.dart';
import '../views/login_view.dart';
import '../views/main_menu_view.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/login': (context) => LoginView(),
  '/main-menu': (context) => MainMenuView(),
  '/nfc-view': (context) => NFCView()
};
