// Flutter imports
import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/material.dart';

// Project imports
import '../core/models/places_model.dart';
import '../core/helpers/Auth_helper.dart';
import '../util/colors.dart' as appColors;
import '../widgets/place_widget.dart';

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
                          return PlaceWidget(
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
}
