import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooke/models/Reservation.dart';
import 'package:hooke/models/RestaurantTable.dart';
import 'package:hooke/utils/Constants.dart';
import 'package:hooke/utils/Globals.dart';
import 'package:hooke/utils/Utils.dart';
import 'package:http/http.dart' as http;

class CreateReservationPage extends StatefulWidget {
  static String tag = 'create-resr';

  @override
  _CreateReservationPageState createState() => _CreateReservationPageState();
}

class _CreateReservationPageState extends State<CreateReservationPage> {
  final _formKey = GlobalKey<FormState>();

  final nrOfPersonsController = TextEditingController();
  final tableIdController = TextEditingController();

  DateTime date = DateTime.now();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(2101));
    if (picked != null && picked != date)
      setState(() {
        date = picked;
      });
  }

  Future<Null> _selectStartTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    // check if it's valid
    if (picked != null && isStartTimeValid(picked)) {
      setState(() {
        startTime = DateTime.utc(
            date.year, date.month, date.day, picked.hour, picked.minute);
      });
    }
  }

  Future<Null> _selectEndTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (picked != null && isEndTimeValid(picked)) {
      setState(() {
        endTime = DateTime.utc(
            date.year, date.month, date.day, picked.hour, picked.minute);
      });
    }
  }

  bool isStartTimeValid(TimeOfDay pickedStart) {
    TimeOfDay now =
        new TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

    if (date.difference(DateTime.now()).inDays == 0) {
      if (pickedStart.hour == now.hour) {
        if (pickedStart.minute <= now.minute) return false;
      }
      if (pickedStart.hour < now.hour) {
        return false;
      }
    }

    return true;
  }

  bool isEndTimeValid(TimeOfDay pickedEnd) {
    DateTime pickedEndDateTime = DateTime.utc(
        date.year, date.month, date.day, pickedEnd.hour, pickedEnd.minute);

    if (pickedEndDateTime.isBefore(DateTime.now()) ||
        pickedEndDateTime.isBefore(startTime)) return false;

    if (pickedEndDateTime.difference(startTime).inMinutes < 30) return false;

    return true;
  }

  Future<void> _createReservation(Reservation res) async {
    http.Client client = new http.Client();

    var wrapper = new Map<String, dynamic>();
    wrapper['reservation'] = res.toJson();

    var response = await client.post(Constants.API_BASE_URL + '/pub/register', 
      headers: {
        'Content-Type': 'application/json',
        'APP_TOKEN': Constants.APP_TOKEN,
        'Authorization': Constants.AUTH_HEADER_PREFIX + Globals.authToken
      },
      body: json.encode(wrapper));

    if (response.statusCode == 200) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Succes!')
          );
        }
      );
    }
    
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Operatia a esuat!')
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    final RestaurantTable selectedTable =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(title: Text('Creare rezervare')),
        body: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Form(
                        key: _formKey,
                        child: ListView(
                          children: <Widget>[
                            MaterialButton(
                              child: Text(
                                  'Data: ' +
                                      Utils.instance.dateFormat.format(date),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 20)),
                              onPressed: () => _selectDate(context),
                            ),
                            MaterialButton(
                                child: Text(
                                    'Ora inceput: ' +
                                        Utils.instance.timeFormat
                                            .format(startTime),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 20)),
                                onPressed: () => _selectStartTime(context)),
                            MaterialButton(
                                child: Text(
                                    'Ora sfarsit: ' +
                                        Utils.instance.timeFormat
                                            .format(endTime),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 20)),
                                onPressed: () => _selectEndTime(context)),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                    'Masa selectata: ' + selectedTable.name,
                                    style: TextStyle(fontSize: 20))),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                    'ID user: ' + Globals.userId.toString(),
                                    style: TextStyle(fontSize: 20)))
                          ],
                        ))),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: MaterialButton(
                            child: Text('Creare rezervare',
                              style: TextStyle(fontSize: 20)),
                            onPressed: () {
                              // creem rezervarea
                              Reservation res = new Reservation(
                                userId: 4,
                                date: date,
                                endTime: endTime,
                                startTime: startTime,
                                nrOfPersons: 1,
                              );
                              _createReservation(res);
                            },
                            color: Colors.lime))
                  ],
                )
              ],
            )));
  }
}
