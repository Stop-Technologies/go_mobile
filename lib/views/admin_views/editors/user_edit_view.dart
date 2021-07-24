// Flutter imports
import 'package:flutter/material.dart';
import 'package:go_mobile/core/helpers/Auth_helper.dart';

// Project imports
import '../../../util/colors.dart' as appColors;
import '../../../util/icons.dart' as appIcons;

// ignore: must_be_immutable
class UserEditView extends StatefulWidget {
  String? id, name, role, placeId;
  bool isNew, blockRole, havePlace;

  UserEditView(
      {Key? key,
      this.id,
      this.name,
      this.role,
      this.placeId,
      this.isNew = false,
      this.blockRole = false,
      this.havePlace = false})
      : super(key: key);

  @override
  _UserEditViewState createState() => _UserEditViewState(
      id: this.id,
      name: this.name,
      role: this.role,
      placeId: this.placeId,
      isNew: this.isNew,
      blockRole: this.blockRole,
      havePlace: this.havePlace);
}

class _UserEditViewState extends State<UserEditView> {
  AuthHelper helper = new AuthHelper();
  List<DropdownMenuItem<String>> places = [], roles = [];
  List<String> rolesNames = ['admin', 'moderator', 'guest'];
  TextEditingController idController = new TextEditingController(),
      nameController = new TextEditingController(),
      roleController = new TextEditingController(),
      placeController = new TextEditingController(),
      passwordController = new TextEditingController();
  String? id, name, role, placeId;
  late String buttonName;
  bool isNew, blockRole, havePlace;
  Color blockColor = appColors.white;
  String? currentValue, roleValue;

  _UserEditViewState(
      {this.id,
      this.name,
      this.role,
      this.placeId,
      this.isNew = false,
      this.blockRole = false,
      this.havePlace = false}) {
    if (this.id != null) this.idController.text = this.id!;
    if (this.name != null) this.nameController.text = this.name!;
    if (this.role != null) this.roleValue = this.role!;
    if (this.placeId != null) this.placeController.text = this.placeId!;
    currentValue = this.placeId;
    _selectButtonName();
    _selectRoleColor();
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
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
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
                                  labelText: 'ID tarjeta',
                                  hintText: 'Ingrese el ID de la tarjeta')),
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
                                  labelText: 'Nombre',
                                  hintText: 'Ingese el nombre')),
                        ),
                      ),
                      _setRole(),
                      SizedBox(height: 12),
                      _setPlace(havePlace),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                              color: appColors.darkBlue,
                              borderRadius: BorderRadius.circular(20)),
                          child: TextButton(
                            onPressed: _onButtonPressed,
                            child: Text(
                              buttonName,
                              style: TextStyle(
                                  color: appColors.white, fontSize: 25),
                            ),
                          ),
                        ),
                      )
                    ]))),
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
      operation = await helper.createUser(
          idController.text, nameController.text, roleValue!, currentValue!);
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
        nameController.text, roleValue!, currentValue!);
    if (operation)
      _messagePopup('Correcto', 'Datos de usuario actualizados correctamente');
  }

  void _selectButtonName() {
    if (isNew)
      this.buttonName = 'Crear';
    else
      this.buttonName = 'Actualizar';
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
      return FutureBuilder(
          future: _initPlaces(),
          builder: (context, AsyncSnapshot<bool> snapshot) => snapshot.hasData
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Container(
                      decoration: BoxDecoration(
                          color: blockColor,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                              child: DropdownButton<String>(
                                  hint: Text('Seleccione un lugar'),
                                  isExpanded: true,
                                  items: places,
                                  value: currentValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      this.currentValue = newValue;
                                    });
                                  })),
                          _setPassword()
                        ],
                      )),
                )
              : SizedBox(height: 0));

    return SizedBox(height: 0);
  }

  Widget _setRole() {
    return FutureBuilder(
        future: _setRoles(),
        builder: (context, snapshot) => snapshot.hasData
            ? Container(
                decoration: BoxDecoration(
                    color: blockColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: DropdownButton<String>(
                        items: roles,
                        value: this.roleValue,
                        isExpanded: true,
                        hint: Text('Seleccione un rol'),
                        onChanged: (newValue) {
                          if (!blockRole) {
                            setState(() {
                              if (newValue != null &&
                                  newValue.compareTo('guest') != 0)
                                this.roleValue = newValue;
                            });
                          } else
                            return null;
                        })),
              )
            : SizedBox(height: 0));
  }

  Widget _setPassword() {
    return isNew
        ? Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
            child: TextField(
                controller: passwordController,
                obscureText: true,
                style: TextStyle(color: appColors.textColor),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Password',
                    hintText: 'Enter the password')))
        : SizedBox(height: 0);
  }

  Future<bool> _setRoles() async {
    roles.clear();

    for (String index in this.rolesNames) {
      this.roles.add(DropdownMenuItem(child: Text(index), value: index));
    }

    return true;
  }

  Future<bool> _initPlaces() async {
    places.clear();

    await helper.placesInfo().then((value) {
      value.forEach((element) {
        places.add(DropdownMenuItem<String>(
            child: Text(element.getName()), value: element.getId()));
      });
    });

    return true;
  }
}
