// Flutter imports
import 'package:go_mobile/views/admin_views/editors/place_edit_view.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/material.dart';

// Project imports
import '../../widgets/admin_widgets/place_widget.dart';
import '../../core/models/places_model.dart';
import '../../core/helpers/Auth_helper.dart';
import '../../util/colors.dart' as appColors;
import '../../util/icons.dart' as appIcons;

class PlacesView extends StatefulWidget {
  const PlacesView({Key? key}) : super(key: key);

  @override
  _PlacesViewState createState() => _PlacesViewState();
}

class _PlacesViewState extends State<PlacesView> {
  AuthHelper _helper = new AuthHelper();
  List<PlacesModel> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: _newPlace,
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
                            return PlaceWidget(
                                id: data.elementAt(index).getId(),
                                name: data.elementAt(index).getName(),
                                occupation:
                                    data.elementAt(index).getOccupation());
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
    this.data = await _helper.placesInfo();
    return true;
  }

  Future<bool> _backArrowPressed() {
    Navigator.pop(context);
    return Future(() => false);
  }

  void _newPlace() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PlaceEditView(id: '', name: '', isNew: true);
    })).then((_) => setState(() {}));
  }
}
