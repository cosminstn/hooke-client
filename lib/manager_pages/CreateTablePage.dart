import 'package:flutter/material.dart';

class CreateTablePage extends StatefulWidget {

  
  @override
  _CreateTablePageState createState() => _CreateTablePageState();
}

class _CreateTablePageState extends State<CreateTablePage> {

  final _formKey = GlobalKey<FormState>();

  final numberController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final maxSeats = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final numberField = Padding(
      padding: EdgeInsets.only(top: 12),
      child: TextFormField(
        keyboardType: TextInputType.number,
        autofocus: false,
        controller: numberController,
        style: TextStyle(fontSize: 18),
        validator: (value) {
          int number = int.parse(value);
          if (number <= 0) {
            return 'Numarul mesei nu poate fi negativ!';
          }

        },
        decoration: InputDecoration(
            labelText: 'Enter your username',
            hintText: 'john.doe',
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      )
    );



    return ListView(
      children: <Widget>[
        numberField
      ],
    );
  }
}