// Flutter imports
import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/material.dart';

// Project imports
import '../widgets/navigation_bar_widget.dart';
import '../core/helpers/Auth_helper.dart';
import '../util/colors.dart' as appColors;

class LoadingView extends StatefulWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  AuthHelper helper = AuthHelper();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _checkLogged(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return snapshot.hasData ? _loadingAnimation() : _loadingAnimation();
        });
  }

  /// The private function _loadingAnimation is used to display a loding
  /// animation where needed
  /// * return a loading animation widget
  Widget _loadingAnimation() {
    return Material(
        color: appColors.lightBlue,
        child: LoadingBouncingGrid.square(
            backgroundColor: appColors.white,
            size: 120,
            duration: Duration(seconds: 2)));
  }

  /// The private function _checkLogged is used to check if a user is
  /// successfully logged
  /// * return false if a user isn't logged or there is not valid refresh token
  Future<bool> _checkLogged() async {
    bool tokens = await helper.hasTokens(),
        usrInfo = await helper.profileInfo();

    // Check if logged and valid tokens
    if (tokens && usrInfo) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  NavigationBar(id: helper.id, name: helper.name)));
      return true;
    }

    // Try to refresh the access tokens if is logged
    if (tokens && !usrInfo) {
      helper.refreshToken();
      return await helper.profileInfo().then((value) async {
        if (value) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NavigationBar(id: helper.id, name: helper.name)));
          return true;
        }

        await helper.removeTokens();
        Navigator.pushReplacementNamed(context, '/login');
        return false;
      });
    }

    Navigator.pushReplacementNamed(context, '/login');
    return false;
  }
}
