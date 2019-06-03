import 'package:flutter/material.dart';
import 'package:hooke/models/RestaurantTable.dart';
import 'package:hooke/utils/FormOperatingModes.dart';


class EditTablePage extends StatefulWidget {

  static String tag = 'edit-table-page';

  @override
  _EditTablePageState createState() => new _EditTablePageState();
}

class _EditTablePageState extends State<EditTablePage> {

  final idController = TextEditingController();
  final numberController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final maxSeatsController = TextEditingController();

  FormOperatingModes mode;

  @override
  Widget build(BuildContext context) {

      final RestaurantTable initialValue = ModalRoute.of(context).settings.arguments;
      
      if (initialValue == null) 
        this.mode = FormOperatingModes.NEW;
      else
        this.mode = FormOperatingModes.UPDATE_OR_DELETE;

      final idField = Padding(
        padding: EdgeInsets.only(top: 12),
        child: TextFormField(
          keyboardType: TextInputType.number,
          autofocus: false,
          controller: idController,
          enabled: false,
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        )
      );

      final numberField = Padding(
        padding: EdgeInsets.only(top: 12),
        child: TextFormField(
          keyboardType: TextInputType.number,
          autofocus: false,
          controller: numberController,
          style: TextStyle(fontSize: 18),
          validator: (value) {
            if (value.isEmpty) {
              return 'Table number required!';
            }
            int iValue = int.tryParse(value);
            if (iValue == null)
              return "Invalid table number";  //parsing failed
            if (iValue < 0 || iValue > 50)
              return "Invalid table number";


          },
          decoration: InputDecoration(
              labelText: 'Enter the table number',
              hintText: '4',
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        )
      );

      final nameField = Padding(
        padding: EdgeInsets.only(top: 12),
        child: TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          controller: nameController,
          validator: (value) {
            if (value.isEmpty) {
              return 'Table name required!';
            }
            if (value.length <= 0 || value.length >= 50) {
              return 'Table name invalid!';
            }
          },
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
              labelText: 'Enter the table name',
              hintText: 'Love table',
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        )
      );

      final descriptionField = Padding(
        padding: EdgeInsets.only(top: 12),
        child: TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          controller: descriptionController,
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
              labelText: 'Enter the table description',
              hintText: 'Perfect for couples',
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        )
      );

      final maxSeatsField = Padding(
        padding: EdgeInsets.only(top: 12),
        child: TextFormField(
          keyboardType: TextInputType.number,
          autofocus: false,
          
          controller: maxSeatsController,
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
              labelText: 'Enter the table max seats',
              hintText: '3',
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        )
      );

      List<Widget> children = List<Widget>();

      children.add(numberField);
      children.add(nameField);
      children.add(descriptionField);
      children.add(maxSeatsField);

      String formTitle = 'Register a table';

      if (this.mode == FormOperatingModes.UPDATE_OR_DELETE) {
        idController.text           = initialValue.id.toString();
        numberController.text       = initialValue.number.toString();
        nameController.text         = initialValue.name;
        descriptionController.text  = initialValue.description ?? '';
        maxSeatsController.text     = initialValue.maxSeats.toString();
      
        children.add(idField);
      }

      
  }
  

}