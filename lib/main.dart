import 'package:flutter/material.dart';
import 'package:hooke/models/Restaurant.dart';
import 'package:hooke/pages/LoginPage.dart';
import 'package:hooke/utils/Routes.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Restaurant> fetchRestaurant(int restaurantId) async {
  print('fetching restaurant...');
  final response = await http.get('http://89.45.197.204:8080/HookeRestApi/webapi/pub/restaurants/' +
                restaurantId.toString(),
                headers: {'APP_TOKEN': 'oL15cdd88Jdzheq8rXttYmuv3fO6jTg5EyX149YorZG12J0mHrp5UPNjjr6jVVkq'});

  if (response.statusCode == 200) {
    return Restaurant.fromJson(json.decode(response.body));
  }
  else {
    throw Exception('Failed to load restaurant with id ' + restaurantId.toString());
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        backgroundColor: Colors.black54
      ),
      home: LoginPage(),
      routes: Routes.routes,
    );
  }
}