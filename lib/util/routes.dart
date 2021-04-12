import 'package:flutter/material.dart';
import '../views/login_view.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/login': (context) => LoginView(),
};
