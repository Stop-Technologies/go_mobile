// Flutter imports;
import 'package:flutter/material.dart';

// Project imports
import '../views/login_view.dart';
import '../views/loading_view.dart';
import '../views/nfc_view.dart';

// Primary routes to app usage
Map<String, Widget Function(BuildContext)> routes = {
  '/loading': (context) => LoadingView(),
  '/login': (context) => LoginView(),
  '/nfc-view': (context) => NFCView()
};
