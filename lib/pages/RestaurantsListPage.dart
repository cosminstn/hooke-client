import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooke/models/Restaurant.dart';
import 'package:hooke/pages/RestaurantDetailsPage.dart';
import 'package:hooke/utils/Constants.dart';

import 'package:http/http.dart' as http;

Future<List<Restaurant>> fetchRestaurants() async {
  http.Client client = http.Client();
  final response = await client.get(
      Constants.API_BASE_URL + '/pub/restaurants/',
      headers: {'APP_TOKEN': Constants.APP_TOKEN});
  return compute<String, List<Restaurant>>(parseRestaurants, response.body);
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
    return FutureBuilder<List<Restaurant>>(
        future: fetchRestaurants(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            throw Exception('${snapshot.error}');
          }
          return snapshot.hasData
              ? _RestaurantsList(restaurants: snapshot.data)
              : Center(child: CircularProgressIndicator());
        });
  }
}

class _RestaurantsList extends StatelessWidget {
  final List<Restaurant> restaurants;

  _RestaurantsList({Key key, this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RestaurantDetailsPage.tag,
                  arguments: restaurants[index]);
            },
            child: Card(
                color: Theme.of(context).primaryColorLight,
                child: Theme(
                    data: Theme.of(context).copyWith(cardColor: Colors.red),
                    child: Column(
                      children: <Widget>[
                        Image.network(restaurants[index].pictureUrl),
                        Text(
                          restaurants[index].name,
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          restaurants[index].description,
                        ),
                        Text(restaurants[index].address,
                            style: TextStyle(fontStyle: FontStyle.italic)),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ))));
      },
    );
  }
}
