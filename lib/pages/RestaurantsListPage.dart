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

Future<List<Restaurant>> fetchRestaurantsOffline() async {
  String offlineJson =
      '[ { "address": "Bulevardul Primăverii nr. 3", "cityId": 1, "description": "Restaurant City Grill in zona Primaverii", "id": 1, "latitude": 44.46709, "longitude": 26.087814, "name": "City Grill Primaverii", "pictureUrl": "https://proxy.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.imperialtransilvania.com%2Ffileadmin%2Farchivio%2Fimperialtransilvania%2FCity_Grill_Primaverii__Bucuresti.jpg&f=1", "registeredDate": "2019-03-01" }, { "address": "Strada Barbu Văcărescu 146-158, București", "cityId": 1, "description": "healthy food", "id": 2, "latitude": 26.1048343, "longitude": 44.4642054, "name": "McDonalds", "pictureUrl": "https://mcdonalds.ro/_pics/ppresa/f3/1.jpg", "registeredDate": "2019-04-20" }, { "address": "Barbu Vacarescu 120-144, KAUFLAND - Food Court, București", "cityId": 1, "description": "healthy food but more expensive", "id": 3, "latitude": 26.1048343, "longitude": 44.4642054, "name": "Subway", "pictureUrl": "https://instilulmeu.ro/wp-content/uploads/2014/05/Subway.jpg", "registeredDate": "2019-04-20" }, { "address": "Bulevardul Ion C. Brătianu 44, București 030167", "cityId": 1, "description": "really nice food", "id": 4, "latitude": 26.1012304, "longitude": 44.4295088, "name": "Borsalino", "pictureUrl": "http://www.out-and-about.ro/wp-content/uploads/2017/08/15541869_1803947856539350_1350104706599420345_n.jpg", "registeredDate": "2019-04-20" } ]';
  return compute(parseRestaurants, offlineJson);
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
        future: fetchRestaurantsOffline(),
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
