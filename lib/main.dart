// FLutter imports
import 'package:flutter/material.dart';

// Project imports
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
      initialRoute: '/loading',
      routes: routes,
    );
  }
}
