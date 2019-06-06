import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooke/models/Restaurant.dart';
import 'package:hooke/utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:hooke/models/RestaurantTable.dart';

class RestaurantDetailsPage extends StatelessWidget {
  static String tag = 'restaurant';

  RestaurantDetailsPage({Key key}) : super(key: key);

  Future<List<RestaurantTable>> fetchRestaurantTables(restaurantId) async {
    http.Client client = http.Client();
    final response = await client.get(
        Constants.API_BASE_URL +
            '/pub/restaurants/' +
            restaurantId.toString() +
            '/tables',
        headers: {'APP_TOKEN': Constants.APP_TOKEN});
    return compute<String, List<RestaurantTable>>(parseTables, response.body);
  }

  static List<RestaurantTable> parseTables(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<RestaurantTable>((json) => RestaurantTable.fromJson(json))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final Restaurant restaurant = ModalRoute.of(context).settings.arguments;

    final tables = fetchRestaurantTables(restaurant.id);

    final aboutPage = ListView(
      children: <Widget>[
        Image.network(restaurant.pictureUrl),
        Padding(
            padding: EdgeInsets.all(10),
            child: Text('Descriere',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontStyle: FontStyle.italic))),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text(
              restaurant.description,
              style: TextStyle(color: Colors.black45),
            )),
        Padding(
            padding: EdgeInsets.all(10),
            child: Text('Adresa',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontStyle: FontStyle.italic))),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text(
              restaurant.address,
              style: TextStyle(color: Colors.black45),
            ))
      ],
    );

    final tablesPage = FutureBuilder<List<RestaurantTable>>(
        future: tables,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            throw Exception('${snapshot.error.toString()}');
          }
          return snapshot.hasData
              ? _TablesList(tables: snapshot.data)
              : Center(child: CircularProgressIndicator());
        });

       // final menuList = FutureBuilder<List<MenuList>>();

    return MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.red, backgroundColor: Colors.black54),
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  bottom: TabBar(
                    tabs: <Widget>[
                      Tab(
                        icon: Icon(Icons.info),
                        text: 'Despre',
                      ),
                      
                      Tab(
                        icon: Icon(Icons.table_chart),
                        text: 'Mese',
                      ),
                      Tab(
                        icon: Icon(Icons.restaurant_menu),
                        text: 'Meniu',
                      )
                    ],
                  ),
                  title: Text(restaurant.name),
                ),
                body: TabBarView(
                  children: [
                    aboutPage,
                    tablesPage,
                    Icon(Icons.directions_bike),
                  ],
                ))));
  }
}


class _TablesList extends StatelessWidget {
  final List<RestaurantTable> tables;

  _TablesList({Key key, this.tables}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: tables.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  child: Card(
                      color: Colors.white24,
                      child: Theme(
                          data:
                              Theme.of(context).copyWith(cardColor: Colors.red),
                          child: Column(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 5, 0),
                              child: Text(tables[index].name,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(15, 5, 10, 0),
                                child: Text(
                                    'Nr. masa: ' +
                                        tables[index].number.toString(),
                                    style: TextStyle(fontSize: 20))),
                            Padding(
                                padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
                                child: Text(
                                    'Nr. locuri: ' +
                                        tables[index].maxSeats.toString(),
                                    style: TextStyle(fontSize: 20)))
                          ], crossAxisAlignment: CrossAxisAlignment.start))));
            }),
       
        );
     }
}

//class _MenuList extends StatelessWidget {
//}