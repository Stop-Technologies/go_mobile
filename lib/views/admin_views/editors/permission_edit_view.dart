// Flutter imports
import 'package:flutter/material.dart';
import 'package:go_mobile/core/helpers/Auth_helper.dart';

// Project imports
import '../../../util/colors.dart' as appColors;
import '../../../util/icons.dart' as appIcons;

// ignore: must_be_immutable
class PermissionEditView extends StatefulWidget {
  late bool _isNew;
  late String? _id,
      _placeId,
      _guestId,
      _startDay,
      _endDay,
      _startTime,
      _endTime;

  PermissionEditView(
      {Key? key,
      String? id,
      String? placeId,
      String? guestId,
      String? startDay,
      String? endDay,
      String? startTime,
      String? endTime,
      bool isNew = false})
      : super(key: key) {
    this._id = id;
    this._placeId = placeId;
    this._guestId = guestId;
    this._startDay = startDay;
    this._startTime = startTime;
    this._endDay = endDay;
    this._endTime = endTime;
    this._isNew = isNew;
  }

  @override
  _PermissionEditViewState createState() => _PermissionEditViewState(
      id: this._id,
      placeId: this._placeId,
      guestId: this._guestId,
      startDay: this._startDay,
      startTime: this._startTime,
      endDay: this._endDay,
      endTime: this._endTime,
      isNew: this._isNew);
}

class _PermissionEditViewState extends State<PermissionEditView> {
  AuthHelper helper = new AuthHelper();
  List<DropdownMenuItem<String>> places = [],
      guests = [],
      days = [],
      hours = [],
      minutes = [];
  List<String> weekDays = [
    'Lunes',
    'Martes',
    'Miercoles',
    'Jueves',
    'Viernes',
    'Sabado',
    'Domingo'
  ];
  String? placeValue,
      guestValue,
      startValue,
      endValue,
      startHour,
      startMinute,
      endHour,
      endMinute,
      id,
      placeId,
      guestId,
      startDay,
      endDay,
      startTime,
      endTime;
  late String buttonName;

  bool isNew;

  _PermissionEditViewState(
      {required this.id,
      required this.placeId,
      required this.guestId,
      required this.startDay,
      required this.endDay,
      required this.startTime,
      required this.endTime,
      this.isNew = false}) {
    placeValue = this.placeId;
    guestValue = this.guestId;
    _selectButtonName();
    if (!isNew) _processData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
          child: FloatingActionButton(
              onPressed: _deletePermission,
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
                        _setPlaceDropDown(
                            _setPlaces, places, 'Seleccione un lugar',
                            topLeft: true, topRight: true),
                        _setGuestDropDown(
                            _setGuests, guests, 'Seleccione un invitado'),
                        _setStartDropDown(
                            _setWeekdays, days, 'Seleccione un día de inicio'),
                        _setEndDropDown(_setWeekdays, days,
                            'Seleccione un día de finalización',
                            bottomLeft: true, bottomRigt: true),
                        SizedBox(height: 20),
                        _setStartHours('Hora de inicio',
                            topLeft: true, topRight: true),
                        _setEndHours('Hora de finalización',
                            bottomLeft: true, bottomRigt: true),
                        SizedBox(height: 20),
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
                      ])))),
    );
  }

  void _onButtonPressed() async {
    if (placeValue != null &&
        guestValue != null &&
        startValue != null &&
        endValue != null &&
        startHour != null &&
        endHour != null &&
        startMinute != null &&
        endMinute != null) {
      bool operation;
      String startHours, endHours, startMinutes, endMinutes;

      startHours = startHour!.length < 2 ? '0${startHour!}' : startHour!;
      startMinutes =
          startMinute!.length < 2 ? '0${startMinute!}' : startMinute!;
      endHours = endHour!.length < 2 ? '0${endHour!}' : endHour!;
      endMinutes = endMinute!.length < 2 ? '0${endMinute!}' : endMinute!;

      if (isNew) {
        operation = await helper.createPermission(
            this.placeValue!,
            this.guestValue!,
            this.startValue!,
            this.endValue!,
            '$startHours:$startMinutes',
            '$endHours:$endMinutes');
        if (operation)
          _messagePopup('Correcto', 'Se ha creado el permiso correctamente');
        return;
      }

      operation = await helper.updatePermission(
          this.id!,
          this.placeValue!,
          this.guestValue!,
          this.startValue!,
          this.endValue!,
          '${this.startHour!}:${this.startMinute!}',
          '${this.endHour!}:${this.endMinute!}');
      if (operation)
        _messagePopup('Correcto', 'Se ha actualizado el permiso correctamente');
    }
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
              content: Text('¿Esta seguro que desea eliminar el permiso?'),
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
    bool operation = await helper.deletePermission(this.id!);
    if (operation)
      _messagePopup('Correcto', 'Se ha eliminado el usuario Correctamente');
  }

  Widget _setPlaceDropDown(
      Function future, List<DropdownMenuItem<String>> items, String hint,
      {bool topLeft = false,
      bool topRight = false,
      bool bottomLeft = false,
      bool bottomRigt = false}) {
    return FutureBuilder(
        future: future(),
        builder: (context, snapshot) => snapshot.hasData
            ? Container(
                decoration: BoxDecoration(
                    color: appColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: _setRadius(topLeft),
                        topRight: _setRadius(topRight),
                        bottomLeft: _setRadius(bottomLeft),
                        bottomRight: _setRadius(bottomRigt))),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    child: DropdownButton<String>(
                        items: items,
                        value: this.placeValue,
                        isExpanded: true,
                        hint: Text(hint),
                        onChanged: (newValue) {
                          setState(() {
                            this.placeValue = newValue;
                          });
                        })),
              )
            : SizedBox(height: 0));
  }

  Widget _setGuestDropDown(
      Function future, List<DropdownMenuItem<String>> items, String hint,
      {bool topLeft = false,
      bool topRight = false,
      bool bottomLeft = false,
      bool bottomRigt = false}) {
    return FutureBuilder(
        future: future(),
        builder: (context, snapshot) => snapshot.hasData
            ? Container(
                decoration: BoxDecoration(
                    color: appColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: _setRadius(topLeft),
                        topRight: _setRadius(topRight),
                        bottomLeft: _setRadius(bottomLeft),
                        bottomRight: _setRadius(bottomRigt))),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    child: DropdownButton<String>(
                        items: items,
                        value: this.guestValue,
                        isExpanded: true,
                        hint: Text(hint),
                        onChanged: (newValue) {
                          setState(() {
                            this.guestValue = newValue;
                          });
                        })),
              )
            : SizedBox(height: 0));
  }

  Widget _setStartDropDown(
      Function future, List<DropdownMenuItem<String>> items, String hint,
      {bool topLeft = false,
      bool topRight = false,
      bool bottomLeft = false,
      bool bottomRigt = false}) {
    return FutureBuilder(
        future: future(),
        builder: (context, snapshot) => snapshot.hasData
            ? Container(
                decoration: BoxDecoration(
                    color: appColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: _setRadius(topLeft),
                        topRight: _setRadius(topRight),
                        bottomLeft: _setRadius(bottomLeft),
                        bottomRight: _setRadius(bottomRigt))),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    child: DropdownButton<String>(
                        items: items,
                        value: this.startValue,
                        isExpanded: true,
                        hint: Text(hint),
                        onChanged: (newValue) {
                          setState(() {
                            this.startValue = newValue;
                          });
                        })),
              )
            : SizedBox(height: 0));
  }

  Widget _setEndDropDown(
      Function future, List<DropdownMenuItem<String>> items, String hint,
      {bool topLeft = false,
      bool topRight = false,
      bool bottomLeft = false,
      bool bottomRigt = false}) {
    return FutureBuilder(
        future: future(),
        builder: (context, snapshot) => snapshot.hasData
            ? Container(
                decoration: BoxDecoration(
                    color: appColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: _setRadius(topLeft),
                        topRight: _setRadius(topRight),
                        bottomLeft: _setRadius(bottomLeft),
                        bottomRight: _setRadius(bottomRigt))),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    child: DropdownButton<String>(
                        items: items,
                        value: this.endValue,
                        isExpanded: true,
                        hint: Text(hint),
                        onChanged: (newValue) {
                          setState(() {
                            this.endValue = newValue;
                          });
                        })),
              )
            : SizedBox(height: 0));
  }

  Widget _setStartHours(String title,
      {bool topLeft = false,
      bool topRight = false,
      bool bottomLeft = false,
      bool bottomRigt = false}) {
    return FutureBuilder(
        future: _setHoursLists(),
        builder: (context, snapshot) => snapshot.hasData
            ? Container(
                decoration: BoxDecoration(
                    color: appColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: _setRadius(topLeft),
                        topRight: _setRadius(topRight),
                        bottomLeft: _setRadius(bottomLeft),
                        bottomRight: _setRadius(bottomRigt))),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    child: Column(children: [
                      Text(title,
                          style: TextStyle(
                              color: appColors.textColor, fontSize: 16)),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: DropdownButton<String>(
                                  items: hours,
                                  value: this.startHour,
                                  hint: Text('Hora'),
                                  onChanged: (newValue) {
                                    setState(() {
                                      this.startHour = newValue;
                                    });
                                  }),
                            ),
                            Expanded(
                              flex: 1,
                              child: DropdownButton<String>(
                                  items: minutes,
                                  value: this.startMinute,
                                  hint: Text('Minutos'),
                                  onChanged: (newValue) {
                                    setState(() {
                                      this.startMinute = newValue;
                                    });
                                  }),
                            )
                          ])
                    ])))
            : SizedBox(height: 0));
  }

  Widget _setEndHours(String title,
      {bool topLeft = false,
      bool topRight = false,
      bool bottomLeft = false,
      bool bottomRigt = false}) {
    return FutureBuilder(
        future: _setHoursLists(),
        builder: (context, snapshot) => snapshot.hasData
            ? Container(
                decoration: BoxDecoration(
                    color: appColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: _setRadius(topLeft),
                        topRight: _setRadius(topRight),
                        bottomLeft: _setRadius(bottomLeft),
                        bottomRight: _setRadius(bottomRigt))),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    child: Column(children: [
                      Text(title,
                          style: TextStyle(
                              color: appColors.textColor, fontSize: 16)),
                      Row(children: [
                        Expanded(
                          child: DropdownButton<String>(
                              items: hours,
                              value: this.endHour,
                              hint: Text('Hora'),
                              onChanged: (newValue) {
                                setState(() {
                                  this.endHour = newValue;
                                });
                              }),
                        ),
                        Expanded(
                          child: DropdownButton<String>(
                              items: minutes,
                              value: this.endMinute,
                              hint: Text('Minutos'),
                              onChanged: (newValue) {
                                setState(() {
                                  this.endMinute = newValue;
                                });
                              }),
                        )
                      ])
                    ])))
            : SizedBox(height: 0));
  }

  Radius _setRadius(bool value) {
    return value ? Radius.circular(15) : Radius.circular(0);
  }

  void _selectButtonName() {
    if (isNew)
      this.buttonName = 'Crear';
    else
      this.buttonName = 'Actualizar';
  }

  Future<bool> _onBackButtonPressed() async {
    Navigator.pop(context);
    return false;
  }

  Future<bool> _setPlaces() async {
    places.clear();

    await helper.placesInfo().then((value) {
      value.forEach((element) {
        places.add(DropdownMenuItem<String>(
            child: Text(element.getName()), value: element.getId()));
      });
    });

    return true;
  }

  Future<bool> _setGuests() async {
    guests.clear();

    await helper.guestsInfo().then((value) {
      value.forEach((element) {
        guests.add(DropdownMenuItem<String>(
            child: Text(element.getName()), value: element.getId()));
      });
    });

    return true;
  }

  Future<bool> _setWeekdays() async {
    int id = 1;
    days.clear();

    weekDays.forEach((element) {
      days.add(
          DropdownMenuItem<String>(child: Text(element), value: id.toString()));
      id++;
    });

    return true;
  }

  Future<bool> _setHoursLists() async {
    hours.clear();
    minutes.clear();

    for (int i = 1; i < 24; i++) {
      hours.add(DropdownMenuItem<String>(
          child: Text(i.toString()), value: i.toString()));
    }

    for (int i = 0; i < 60; i++) {
      minutes.add(DropdownMenuItem<String>(
          child: Text(i.toString()), value: i.toString()));
    }

    return true;
  }

  void _processData() {
    List<String> result;
    this.startValue = _convertWeekday(this.startDay!);
    this.endValue = _convertWeekday(this.endDay!);

    result = this.startTime!.split(':');
    this.startHour = int.parse(result.elementAt(0)).toString();
    this.startMinute = int.parse(result.elementAt(1)).toString();

    result = this.endTime!.split(':');
    this.endHour = int.parse(result.elementAt(0)).toString();
    this.endMinute = int.parse(result.elementAt(1)).toString();
  }

  String _convertWeekday(String weekday) {
    switch (weekday) {
      case 'Lunes':
        return '1';

      case 'Martes':
        return '2';

      case 'Miercoles':
        return '3';

      case 'Jueves':
        return '4';

      case 'Viernes':
        return '5';

      case 'Sabado':
        return '6';

      case 'Domingo':
        return '7';

      default:
        return '1';
    }
  }

  void _deletePermission() {
    _deletionPopup('Alerta');
  }
}
