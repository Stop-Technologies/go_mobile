// Flutter imports
import 'package:go_mobile/views/admin_views/editors/user_edit_view.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/material.dart';

// Project imports
import '../../widgets/admin_widgets/user_widget.dart';
import '../../util/colors.dart' as appColors;
import '../../core/helpers/Auth_helper.dart';
import '../../core/models/users_model.dart';
import '../../util/icons.dart' as appIcons;

class GuestsView extends StatefulWidget {
  const GuestsView({Key? key}) : super(key: key);

  @override
  _GuestsViewState createState() => _GuestsViewState();
}

class _GuestsViewState extends State<GuestsView> {
  AuthHelper _helper = new AuthHelper();
  List<UsersModel> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: _newGuest,
          backgroundColor: appColors.darkBlue,
          child: Icon(appIcons.addValue)),
      body: WillPopScope(
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
                                role: data.elementAt(index).getRole(),
                                blockRole: true);
                          },
                        )
                      : Center(
                          child: LoadingBouncingGrid.square(
                              backgroundColor: appColors.white,
                              size: 120,
                              duration: Duration(seconds: 2)));
                })),
      ),
    );
  }

  Future<bool> _getData() async {
    this.data = await _helper.guestsInfo();
    return true;
  }

  Future<bool> _backArrowPressed() {
    Navigator.pop(context);
    return Future(() => false);
  }

  void _newGuest() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UserEditView(role: 'guest', isNew: true, blockRole: true);
    })).then((_) => setState(() {}));
  }
}
