// Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports
import '../services/backend_access/backend_service.dart';
import '../util/colors.dart' as appColors;
import '../util/icons.dart' as appIcons;

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController idController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: appColors.lightBlue,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Go',
                  style: TextStyle(color: appColors.lightGrey, fontSize: 40)),
              SvgPicture.asset(
                appIcons.goIcon,
                color: appColors.lightGrey,
                width: 50,
              ),
              SizedBox(height: 25),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                    decoration: BoxDecoration(
                        color: appColors.lightGrey,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15, top: 0, right: 15, bottom: 0),
                          child: TextField(
                            controller: idController,
                            style: TextStyle(color: appColors.textColor),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Username',
                                hintText: 'Enter your username'),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 0, bottom: 5),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            style: TextStyle(color: appColors.textColor),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Password',
                                hintText: 'Enter your secure password'),
                          ),
                        ),
                      ],
                    )),
              ),
              Container(
                child: TextButton(
                  onPressed: () {
                    //TODO: Create a view for this and push it here
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(color: appColors.lightGrey, fontSize: 15),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: appColors.darkBlue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: onLoginButtonPressed,
                  child: Text(
                    'Login',
                    style: TextStyle(color: appColors.lightGrey, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onLoginButtonPressed() async {
    var service = BackendService();
    service
        .authenticate(idController.text, passwordController.text)
        .then((result) {
      if (result['success']) {
        Navigator.pushReplacementNamed(context, '/nfc-view');
      } else {
        setState(() {
          idController.clear();
          passwordController.clear();
        });
      }
    });
  }
}
