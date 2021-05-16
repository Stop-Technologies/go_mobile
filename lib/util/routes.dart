// Flutter imports;
import 'package:flutter/material.dart';
import 'package:go_mobile/views/nfc_view.dart';

// Project imports
import '../views/login_view.dart';
import '../widgets/navigation_bar_widget.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/login': (context) => LoginView(),
  '/nfc-view': (context) => NFCView(),
  '/nav': (context) => NavigationBar()
};
