// Flutter imports
import 'package:flutter/material.dart';

// Project imports
import '../core/helpers/Auth_helper.dart';
import '../util/colors.dart' as appColors;

// ignore: must_be_immutable
class ProfileData extends StatefulWidget {
  late String name, id;

  ProfileData({required this.name, required this.id});

  @override
  _ProfileDataState createState() =>
      _ProfileDataState(name: this.name, id: this.id);
}

class _ProfileDataState extends State<ProfileData> {
  AuthHelper helper = AuthHelper();
  late String name, id;

  _ProfileDataState({required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: appColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35))),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 30, 30, 1),
                  child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: appColors.lightGrey,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            name,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ))),
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 2, 30, 1),
                  child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: appColors.lightGrey,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            id,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ))),
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 18, 30, 30),
                  child: Container(
                      decoration: BoxDecoration(
                          color: appColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: appColors.darkBlue,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextButton(
                                onPressed: _onLogoutButtonPressed,
                                child: Text(
                                  'Log Out',
                                  style: TextStyle(
                                      color: appColors.white, fontSize: 25),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  //TODO: Create a view for this and push it here
                                },
                                child: Text(
                                  'Need Help?',
                                  style: TextStyle(
                                      color: appColors.textColor, fontSize: 15),
                                ),
                              ),
                            )
                          ])))
            ]));
  }

  /// Is an asyncronous private function used to log out from the backend
  /// services and revoke the tokens from the app
  void _onLogoutButtonPressed() async {
    if (!await helper.logOut()) helper.removeTokens();

    Navigator.pushReplacementNamed(context, '/login');
  }
}
