// Flutter imports
import 'package:go_mobile/views/admin_views/editors/permission_edit_view.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/material.dart';

// Project imports
import '../../core/models/permissions_model.dart';
import '../../widgets/admin_widgets/permission_widget.dart';
import '../../core/helpers/Auth_helper.dart';
import '../../util/colors.dart' as appColors;
import '../../util/icons.dart' as appIcons;

class PermissionsView extends StatefulWidget {
  const PermissionsView({Key? key}) : super(key: key);

  @override
  _PermissionsViewState createState() => _PermissionsViewState();
}

class _PermissionsViewState extends State<PermissionsView> {
  AuthHelper _helper = new AuthHelper();
  List<PermissionModel> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: _newPermission,
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
                            return PermissionWidget(
                                id: data.elementAt(index).getId(),
                                placeId: data.elementAt(index).getPlaceId(),
                                place: data.elementAt(index).getPlace(),
                                guestId: data.elementAt(index).getGuestId(),
                                guest: data.elementAt(index).getGuest(),
                                days: data.elementAt(index).getDay(),
                                hours: data.elementAt(index).getHour());
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
    this.data = await _helper.permissionInfo();
    return true;
  }

  Future<bool> _backArrowPressed() {
    Navigator.pop(context);
    return Future(() => false);
  }

  void _newPermission() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PermissionEditView(isNew: true);
    })).then((_) => setState(() {}));
  }
}
