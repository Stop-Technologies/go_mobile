//import 'dart:html';

import 'package:flutter/material.dart';
import 'util/routes.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/access-view',
      routes: routes,
    );
  }
}
