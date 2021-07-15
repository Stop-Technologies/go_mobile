// Flutter imports
import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/material.dart';

// Project imports
import '../core/helpers/Auth_helper.dart';
import '../util/colors.dart' as appColors;
import '../core/models/users_model.dart';
import '../widgets/user_widget.dart';

class UsersView extends StatefulWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  _UsersViewState createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  AuthHelper _helper = new AuthHelper();
  List<UsersModel> data = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backArrowPressed,
      child: Material(
          color: appColors.lightBlue,
          child: FutureBuilder(
              future: _getData(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return UserWidget(
                              id: data.elementAt(index).getId(),
                              name: data.elementAt(index).getName(),
                              role: data.elementAt(index).getRole());
                        },
                      )
                    : Center(
                        child: LoadingBouncingGrid.square(
                            backgroundColor: appColors.white,
                            size: 120,
                            duration: Duration(seconds: 2)));
              })),
    );
  }

  Future<bool> _getData() async {
    this.data = await _helper.usersInfo();
    return true;
  }

  Future<bool> _backArrowPressed() {
    Navigator.pop(context);
    return Future(() => false);
  }
}
