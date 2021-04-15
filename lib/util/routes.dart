import 'package:flutter/material.dart';
import '../views/login_view.dart';
import '../views/main_menu_view.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/login': (context) => LoginView(),
  '/main-menu': (context) => MainMenuView(),
};
