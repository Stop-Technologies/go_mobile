// Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports
import '../widgets/navigation_bar_widget.dart';
import '../core/helpers/Auth_helper.dart';
import '../util/colors.dart' as appColors;
import '../util/icons.dart' as appIcons;

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController idController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  AuthHelper helper = AuthHelper();

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
                  style: TextStyle(color: appColors.white, fontSize: 40)),
              SvgPicture.asset(
                appIcons.goIcon,
                color: appColors.white,
                width: 50,
              ),
              SizedBox(height: 25),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                    decoration: BoxDecoration(
                        color: appColors.white,
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
                                labelText: 'Card ID',
                                hintText: 'Enter your Card ID'),
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
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: appColors.darkBlue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () => onLoginButtonPressed(context),
                  child: Text(
                    'Log In',
                    style: TextStyle(color: appColors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: TextButton(
                  onPressed: () {
                    errorPopup('Esta función no está implementada de momento');
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(color: appColors.white, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onLoginButtonPressed(BuildContext context) async {
    bool login = await helper
        .logIn(idController.text, passwordController.text)
        .then((value) => value);

    if (!login) {
      idController.text = "";
      passwordController.text = "";
      errorPopup('Algun dato ingresado es incorrecto');
      return;
    }

    bool info = await helper.profileInfo().then((value) => value);

    if (!info) {
      errorPopup('La respuesta del servidor no fue posible');
      return;
    }

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                NavigationBar(id: helper.id, name: helper.name)));
  }

  void errorPopup(String message) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Error'),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'))
              ],
            ));
  }
}
