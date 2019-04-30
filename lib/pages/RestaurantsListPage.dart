import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooke/models/Restaurant.dart';
import 'package:hooke/utils/Constants.dart';

import 'package:http/http.dart' as http;

Future<List<Restaurant>> fetchRestaurants() async { 
  http.Client client = http.Client();
  final response = await client.get(Constants.API_BASE_URL + '/pub/restaurants/',
                                    headers: {'APP_TOKEN' : Constants.APP_TOKEN});
  return compute<String, List<Restaurant>> (parseRestaurants, response.body);
}

List<Restaurant> parseRestaurants(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Restaurant>((json) => Restaurant.fromJson(json)).toList();
}

class RestaurantsListPage extends StatelessWidget {
  static String tag = 'restaurants-list';

  RestaurantsListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista restaurante'),),
      body: FutureBuilder<List<Restaurant>> (
        future: fetchRestaurants(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            throw Exception('${snapshot.error}');
          }
          return snapshot.hasData ? _RestaurantsList(restaurants: snapshot.data) :
                                    Center(child: CircularProgressIndicator());
        }
      )
    );
  }
}

class _RestaurantsList  extends StatelessWidget {
  final List<Restaurant> restaurants;

  _RestaurantsList({Key key, this.restaurants}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1
      ),
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        return Image.network(restaurants[index].pictureUrl);
      },
    );
  }
}