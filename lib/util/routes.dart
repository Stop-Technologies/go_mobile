// Flutter imports;
import 'package:flutter/material.dart';

// Project imports
import '../views/login_view.dart';
import '../views/loading_view.dart';
import '../views/nfc_view.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/loading': (context) => LoadingView(),
  '/login': (context) => LoginView(),
  '/nfc-view': (context) => NFCView()
};
