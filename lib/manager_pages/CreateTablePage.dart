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
  final maxSeatsController = TextEditingController();

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
              labelText: 'Introdu numarul mesei',
              hintText: '2',
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ));

    final maxSeatsField = Padding(
        padding: EdgeInsets.only(top: 12),
        child: TextFormField(
          keyboardType: TextInputType.number,
          autofocus: false,
          controller: maxSeatsController,
          style: TextStyle(fontSize: 18),
          validator: (value) {
            int number = int.parse(value);
            if (number <= 0) {
              return 'Numarul maxim de persoane nu poate fi negativ!';
            }
          },
          decoration: InputDecoration(
              labelText: 'Numarul maxim de persoane',
              hintText: '2',
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ));

    final nameField = Padding(
        padding: EdgeInsets.only(top: 12),
        child: TextFormField(
          keyboardType: TextInputType.number,
          autofocus: false,
          controller: nameController,
          style: TextStyle(fontSize: 18),
          validator: (value) {},
          decoration: InputDecoration(
              labelText: 'Introdu numele mesei(optional)',
              hintText: 'Masa rotunda',
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ));

    final descriptionField = Padding(
        padding: EdgeInsets.only(top: 12),
        child: TextFormField(
          keyboardType: TextInputType.number,
          autofocus: false,
          controller: nameController,
          style: TextStyle(fontSize: 18),
          validator: (value) {},
          decoration: InputDecoration(
              labelText: 'Introdu descrierea mesei(optional)',
              hintText: '2',
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ));

    return Padding(
        padding: EdgeInsets.all(5),
        child: Form(
            key: _formKey,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    numberField, 
                    maxSeatsField, 
                    nameField, 
                    descriptionField],
                )
            )
        )
      );
  }
}
