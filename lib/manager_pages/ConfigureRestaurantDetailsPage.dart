import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooke/models/Restaurant.dart';
import 'package:hooke/utils/Constants.dart';
import 'package:hooke/utils/Globals.dart';
import 'package:http/http.dart' as http;

class ConfigureRestaurantDetailsPage extends StatelessWidget {
  Future<Restaurant> fetchRestaurantByCreator() async {
    http.Client client = http.Client();
    final response = await client
        .get(Constants.API_BASE_URL + '/pub/restaurants/bycreator', headers: {
      'APP_TOKEN': Constants.APP_TOKEN,
      'Authorization': Globals.authToken
    }).timeout(Duration(seconds: 3));
    return compute(parseSingleRestaurant, response.body);
  }

  static Restaurant parseSingleRestaurant(String responseBody) {
    print(responseBody);
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return Restaurant.fromJson(parsed);
  }

  static final String tag = 'conf-rest-details';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Restaurant>(
        future: fetchRestaurantByCreator(),
        builder: (context, snapshot) {
          if (snapshot.hasError) throw Exception('${snapshot.error}');
          return snapshot.hasData
              ? _RestaurantDetailsForm(dbRestaurantInstance: snapshot.data)
              : Center(child: CircularProgressIndicator());
        });
  }
}

class _RestaurantDetailsForm extends StatefulWidget {
  final Restaurant dbRestaurantInstance;

  _RestaurantDetailsForm({Key key, this.dbRestaurantInstance})
      : super(key: key);

  @override
  _RestaurantDetailsFormState createState() => _RestaurantDetailsFormState();
}

class _RestaurantDetailsFormState extends State<_RestaurantDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descController = TextEditingController();
  final picUrlController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //initial values
    nameController.text = widget.dbRestaurantInstance.name;
    descController.text = widget.dbRestaurantInstance.description;
    picUrlController.text = widget.dbRestaurantInstance.pictureUrl;
    addressController.text = widget.dbRestaurantInstance.address;

    final nameField = Padding(
        padding: EdgeInsets.only(top: 12),
        child: TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          controller: nameController,
          style: TextStyle(fontSize: 18),
          validator: (value) {
            if (value.length <= 0) {
              return 'Numele restaurantului este obligatoriu!';
            }
          },
          decoration: InputDecoration(
              labelText: 'Introdu numele restaurantului',
              hintText: 'Pescarus',
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ));

    final descField = Padding(
        padding: EdgeInsets.only(top: 12),
        child: TextFormField(
          keyboardType: TextInputType.multiline,
          autofocus: false,
          controller: descController,
          minLines: 1,
          maxLines: 5,
          style: TextStyle(fontSize: 18),
          validator: (value) {
            if (value.length <= 0) {
              return 'Descrierea restaurantului este obligatorie!';
            }
          },
          decoration: InputDecoration(
              labelText: 'Introdu descrierea restaurantului',
              hintText: 'Cel mai jmecher restaurant din zona',
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ));

    final picUrlField = Padding(
        padding: EdgeInsets.only(top: 12),
        child: TextFormField(
          keyboardType: TextInputType.url,
          autofocus: false,
          controller: picUrlController,
          style: TextStyle(fontSize: 18),
          validator: (value) {
            if (value.length <= 0) {
              return 'Restaurantul are nevoie neaparata de o imagine de profil';
            }
          },
          decoration: InputDecoration(
              labelText: 'Introdu link-ul catre o poza a restaurantului!',
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ));

    final addressField = Padding(
        padding: EdgeInsets.only(top: 12),
        child: TextFormField(
          keyboardType: TextInputType.url,
          autofocus: false,
          controller: addressController,
          style: TextStyle(fontSize: 18),
          validator: (value) {
            if (value.length <= 0) {
              return 'Adresa este obligatorie!';
            }
          },
          decoration: InputDecoration(
              labelText: 'Introdu adresa restaurantului!',
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ));

    return Form(
        key: _formKey,
        child: ListView(children: <Widget>[
          nameField,
          descField,
          picUrlField,
          addressField
        ]));
  }
}
