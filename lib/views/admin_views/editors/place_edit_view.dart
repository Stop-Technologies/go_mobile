// Flutter imports
import 'package:flutter/material.dart';
import 'package:go_mobile/core/helpers/Auth_helper.dart';

// project imports
import '../../../util/colors.dart' as appColors;
import '../../../util/icons.dart' as appIcons;

// ignore: must_be_immutable
class PlaceEditView extends StatefulWidget {
  late String _id, _name;
  late bool _isNew;

  PlaceEditView(
      {Key? key, required String id, required String name, bool isNew = false})
      : super(key: key) {
    this._id = id;
    this._name = name;
    this._isNew = isNew;
  }

  @override
  _PlaceEditViewState createState() =>
      _PlaceEditViewState(id: this._id, name: this._name, isNew: this._isNew);
}

class _PlaceEditViewState extends State<PlaceEditView> {
  AuthHelper helper = new AuthHelper();
  TextEditingController idController = new TextEditingController(),
      nameController = new TextEditingController();
  String id, name, buttonName = '';
  bool isNew;

  _PlaceEditViewState(
      {required this.id, required this.name, required this.isNew}) {
    this.idController.text = this.id;
    this.nameController.text = this.name;
    _selectButtonName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
          child: FloatingActionButton(
              onPressed: _deletePlace,
              backgroundColor: appColors.darkBlue,
              child: Icon(appIcons.removeValue)),
          visible: !isNew),
      body: WillPopScope(
          onWillPop: _onBackButtonPressed,
          child: Material(
              color: appColors.lightBlue,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: appColors.lightGrey,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: TextField(
                              controller: idController,
                              enabled: false,
                              style: TextStyle(color: appColors.textColor),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Place ID',
                                  hintText: 'Enter the Place ID')),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: appColors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: TextField(
                              controller: nameController,
                              style: TextStyle(color: appColors.textColor),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Name',
                                  hintText: 'Enter the Place Name')),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: appColors.darkBlue,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: _onButtonPressed,
                          child: Text(
                            buttonName,
                            style:
                                TextStyle(color: appColors.white, fontSize: 25),
                          ),
                        ),
                      )
                    ]),
              ))),
    );
  }

  Future<bool> _onBackButtonPressed() async {
    Navigator.pop(context);
    return true;
  }

  void _onButtonPressed() async {
    bool operation;

    if (isNew) {
      operation = await helper.createPlace(nameController.text);
      print(operation);
      if (operation)
        _messagePopup('Correcto', 'El lugar fue creado correctamente');
      return;
    }

    operation = await helper.updatePlace(this.id, nameController.text);
    if (operation)
      _messagePopup('Correcto', 'El lugar fue creado correctamente');
  }

  void _deletePlace() {
    _deletionPopup('Alerta');
  }

  void _selectButtonName() {
    if (isNew)
      this.buttonName = 'Create';
    else
      this.buttonName = 'Update';
  }

  /// The private function _messagePopup is used to display an alert dialog when an
  /// error ocurrs
  void _messagePopup(String title, String message) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'OK');
                      Navigator.pop(context);
                    },
                    child: const Text('OK'))
              ],
            ));
  }

  void _deletionPopup(String title) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text('¿Esta seguro que desea eliminar el lugar?'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'Si');
                      _deleteData();
                    },
                    child: const Text('Si')),
                TextButton(
                    onPressed: () => Navigator.pop(context, 'No'),
                    child: const Text('No'))
              ],
            ));
  }

  void _deleteData() async {
    bool operation = await helper.deletePlace(this.id);
    if (operation)
      _messagePopup('Correcto', 'Se ha eliminado el usuario Correctamente');
  }
}
