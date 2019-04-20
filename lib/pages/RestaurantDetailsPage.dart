import 'package:flutter/material.dart';
import 'package:hooke/models/Restaurant.dart';

import 'dart:async';

class RestaurantDetailsPage extends StatelessWidget {
  static String tag = 'restaurant'; 
  final Future<Restaurant> restaurant;

  RestaurantDetailsPage({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch data example'),
      ),
      body: Center(
        child: FutureBuilder<Restaurant>(
          future: restaurant,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.name);
            }
            else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return CircularProgressIndicator();
          },
        ),
      )
    );
  }
}