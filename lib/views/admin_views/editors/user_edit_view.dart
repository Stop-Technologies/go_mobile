// Flutter imports
import 'package:flutter/material.dart';
import 'package:go_mobile/core/helpers/Auth_helper.dart';

// Project imports
import '../../../util/colors.dart' as appColors;
import '../../../util/icons.dart' as appIcons;

// ignore: must_be_immutable
class UserEditView extends StatefulWidget {
  String? id, name, role, place_id;
  bool isNew, blockRole, havePlace;

  UserEditView(
      {Key? key,
      this.id,
      this.name,
      this.role,
      this.place_id,
      this.isNew = false,
      this.blockRole = false,
      this.havePlace = false})
      : super(key: key);

  @override
  _UserEditViewState createState() => _UserEditViewState(
      id: this.id,
      name: this.name,
      role: this.role,
      place_id: this.place_id,
      isNew: this.isNew,
      blockRole: this.blockRole,
      havePlace: this.havePlace);
}

class _UserEditViewState extends State<UserEditView> {
  AuthHelper helper = new AuthHelper();
  List<DropdownMenuItem> places = [];
  TextEditingController idController = new TextEditingController(),
      nameController = new TextEditingController(),
      roleController = new TextEditingController(),
      placeController = new TextEditingController();
  String? id, name, role, place_id;
  late String buttonName;
  bool isNew, blockRole, havePlace;
  Color blockColor = appColors.white;

  _UserEditViewState(
      {this.id,
      this.name,
      this.role,
      this.place_id,
      this.isNew = false,
      this.blockRole = false,
      this.havePlace = false}) {
    if (this.id != null) this.idController.text = this.id!;
    if (this.name != null) this.nameController.text = this.name!;
    if (this.role != null) this.roleController.text = this.role!;
    if (this.place_id != null) this.placeController.text = this.place_id!;
  }

  @override
  void initState() {
    _selectButtonName();
    _selectRoleColor();
    _initPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
          child: FloatingActionButton(
              onPressed: _deleteUser,
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
                          color: appColors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: TextField(
                            controller: idController,
                            style: TextStyle(color: appColors.textColor),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Card ID',
                                hintText: 'Enter the Card ID')),
                      ),
                    ),
                    Container(
                      color: appColors.white,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: TextField(
                            controller: nameController,
                            style: TextStyle(color: appColors.textColor),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Name',
                                hintText: 'Enter the Name')),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: blockColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: TextField(
                            enabled: !blockRole,
                            controller: roleController,
                            style: TextStyle(color: appColors.textColor),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Role',
                                hintText: 'Enter the Role')),
                      ),
                    ),
                    SizedBox(height: 30),
                    _setPlace(havePlace),
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
            )),
      ),
    );
  }

  Future<bool> _onBackButtonPressed() async {
    Navigator.pop(context);
    return true;
  }

  void _onButtonPressed() async {
    bool operation;
    if (isNew && blockRole) {
      operation =
          await helper.createGuest(idController.text, nameController.text);
      if (operation) _messagePopup('Correcto', 'Invitado creado correctamente');

      return;
    }

    if (isNew) {
      operation = await helper.createUser(idController.text,
          nameController.text, roleController.text, placeController.text);
      if (operation) _messagePopup('Correcto', 'Usuario creado correctamente');

      return;
    }

    if (blockRole) {
      operation = await helper.updateGuest(
          this.id!, idController.text, nameController.text);
      if (operation)
        _messagePopup(
            'Correcto', 'Datos de invitado actualizados correctamente');

      return;
    }

    operation = await helper.updateUser(this.id!, idController.text,
        nameController.text, roleController.text, placeController.text);
    if (operation)
      _messagePopup('Correcto', 'Datos de usuario actualizados correctamente');
  }

  void _selectButtonName() {
    if (isNew)
      this.buttonName = 'Create';
    else
      this.buttonName = 'Update';
  }

  void _selectRoleColor() {
    if (blockRole) blockColor = appColors.lightGrey;
  }

  void _deleteUser() async {
    if (blockRole) {
      _deletionPopup('Alerta', 'invitado');
      return;
    }

    _deletionPopup('Alerta', 'usuario');
  }

  void _deleteData() async {
    bool operation;
    if (blockRole) {
      operation = await helper.deleteGuest(this.id!);
      if (operation)
        _messagePopup('Correcto', 'Se ha eliminado el invitado correctamente');
      return;
    }

    operation = await helper.deleteUser(this.id!);
    if (operation)
      _messagePopup('Correcto', 'Se ha eliminado el usuario Correctamente');
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

  void _deletionPopup(String title, String type) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text('¿Esta seguro que desea eliminar el $type?'),
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

  Widget _setPlace(bool havePlace) {
    if (havePlace)
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
        child: Container(
            decoration: BoxDecoration(
                color: blockColor,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: DropdownButton(items: places, value: this.place_id))),
      );

    return SizedBox(height: 0);
  }

  void _initPlaces() async {
    await helper.placesInfo().then((value) {
      value.forEach((element) {
        print('${element.getName()} - ${element.getId()}');
        places.add(DropdownMenuItem(
            child: Text(element.getName()), value: element.getId()));

        print(places.elementAt(0).value);
        print(this.place_id);
      });
    });
  }
}
