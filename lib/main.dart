import 'package:flutter/material.dart';
import 'package:hooke/models/Restaurant.dart';
import 'package:hooke/pages/LoginPage.dart';
import 'package:hooke/pages/HomePage.dart';
import 'package:hooke/pages/RestaurantDetailsPage.dart';
import 'package:hooke/pages/PhotosPage.dart';
import 'package:hooke/pages/RestaurantsListPage.dart';
import 'package:hooke/pages/RestaurantHomePage.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Restaurant> fetchRestaurant(int restaurantId) async {
  print('fetching restaurant...');
  final response = await http.get('http://192.168.10.37:8080/HookeRestApi/webapi/pub/restaurants/' +
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
  
  final routes = <String, WidgetBuilder> {
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag:  (context) => HomePage(),
    RestaurantDetailsPage.tag: (context) => RestaurantDetailsPage(restaurant: fetchRestaurant(1)),
    PhotosPage.tag: (context) => PhotosPage(),
    RestaurantsListPage.tag: (context) => RestaurantsListPage(),
    '/logout':     (context) => LoginPage()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}


// void main() {
//   runApp(BasicAppBarSample());
// }