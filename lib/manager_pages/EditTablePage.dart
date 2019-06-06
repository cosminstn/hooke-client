import 'package:flutter/material.dart';
import 'package:hooke/models/RestaurantTable.dart';
import 'package:hooke/utils/FormOperatingModes.dart';

class EditTablePage extends StatefulWidget {
  static String tag = 'edit-table-page';

  EditTablePage({Key key}) : super(key: key);

  @override
  _EditTablePageState createState() => new _EditTablePageState();
}

class _EditTablePageState extends State<EditTablePage> {
  final idController = TextEditingController();
  final numberController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final maxSeatsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  FormOperatingModes mode;

  @override
  Widget build(BuildContext context) {
    final RestaurantTable initialValue =
        ModalRoute.of(context).settings.arguments;

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
              labelText: 'Table id',
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ));

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
            if (iValue == null) return "Invalid table number"; //parsing failed
            if (iValue < 0 || iValue > 50) return "Invalid table number";
          },
          decoration: InputDecoration(
              labelText: 'Enter the table number',
              hintText: '4',
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ));

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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ));

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
          decoration: InputDecoration(
              labelText: 'Enter the table max seats',
              hintText: '3',
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ));

    final saveBtn = Padding(
        padding: EdgeInsets.all(10),
        child: MaterialButton(
          color: Colors.lime,
          child: Text('Save'),
          onPressed: () {
            print('updating table...');
          },
        ));

    final delBtn = Padding(
        padding: EdgeInsets.all(10),
        child: MaterialButton(
          color: Colors.red,
          child: Text('Delete'),
          onPressed: () {
            showDialog(context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('Deleting a table is a permanent operation and cannot be reverted!'),
                  actions: <Widget>[
                    MaterialButton(
                      color: Colors.red,
                      child: Text('DELETE'),
                      onPressed: () {
                        deleteTable(initialValue.id);
                        Navigator.of(context).pop();
                      },
                    ),
                    MaterialButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              }
            );
          },
        ));

    List<Widget> form = List<Widget>();

    form.add(numberField);
    form.add(nameField);
    form.add(descriptionField);
    form.add(maxSeatsField);

    String formTitle = 'Register a table';

    List<Widget> actionButtons = List<Widget>();
    actionButtons.add(Expanded(child: saveBtn));

    if (this.mode == FormOperatingModes.UPDATE_OR_DELETE) {
      idController.text = initialValue.id.toString();
      numberController.text = initialValue.number.toString();
      nameController.text = initialValue.name;
      descriptionController.text = initialValue.description ?? '';
      maxSeatsController.text = initialValue.maxSeats.toString();

      form.insert(0, idField);
      formTitle = 'Update table ' + initialValue.number.toString();

      // add the delete button
      actionButtons.add(Expanded(child: delBtn));
    }

    final col = Column(
      verticalDirection: VerticalDirection.down,
      children: <Widget>[
        Expanded(child: ListView(children: form)),
        Row(children: actionButtons)
      ],
    );

    return Scaffold(
        appBar: AppBar(title: Text(formTitle)),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(key: _formKey, child: col)));
  }

  Future<bool> deleteTable(int tableId) async {
    
  }
}
