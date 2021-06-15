// Flutter imports
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

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
        future: checkLogged(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return snapshot.hasData ? loadingAnimation() : loadingAnimation();
        });
  }

  Widget loadingAnimation() {
    return Material(
        color: appColors.lightBlue,
        child: LoadingBouncingGrid.square(
            backgroundColor: appColors.white,
            size: 120,
            duration: Duration(seconds: 2)));
  }

  Future<bool> checkLogged() async {
    bool tokens = await helper.hasTokens(),
        usrInfo = await helper.profileInfo();

    if (tokens && usrInfo) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  NavigationBar(id: helper.id, name: helper.name)));
      return true;
    }

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
