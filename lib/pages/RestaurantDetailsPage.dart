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

<<<<<<< HEAD
  Future<List<HookeTable.Table>> fetchRestaurantTables(int restaurantId) async {
    http.Client client = http.Client();
    final response = await client.get(Constants.API_BASE_URL + '/pub/restaurants/' + restaurantId.toString() + '/tables',
=======
  Future<List<RestaurantTable>> fetchRestaurantTables(restaurantId) async {
    http.Client client = http.Client();
    final response = await client.get(Constants.API_BASE_URL + '/pub/restaurants/' + restaurantId + '/tables',
>>>>>>> adminHUD
                                      headers: {'APP_TOKEN' : Constants.APP_TOKEN});
    return compute<String, List<RestaurantTable>> (parseTables, response.body);
  }

<<<<<<< HEAD
  static List<HookeTable.Table> parseTables(String responseBody) {
=======
  List<RestaurantTable> parseTables(String responseBody) {
>>>>>>> adminHUD
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<RestaurantTable>((json) => RestaurantTable.fromJson(json)).toList();
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
          child: Text(
            'Descriere', 
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontStyle: FontStyle.italic
            )
          ) 
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Text(
            restaurant.description, 
            style: TextStyle(
              color: Colors.black45
            ),
          )
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Adresa', 
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontStyle: FontStyle.italic
            )
          ) 
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Text(
            restaurant.address, 
            style: TextStyle(
              color: Colors.black45
            ),
          )
        )
      ],
    );

    final tablesPage = FutureBuilder<List<RestaurantTable>>(
      future: tables,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            throw Exception('${snapshot.error.toString()}');
          }
          return snapshot.hasData ? _TablesList(tables: snapshot.data) :
                                    Center(child: CircularProgressIndicator());
        }
    );

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        backgroundColor: Colors.black54
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.info), text: 'Despre',),
                Tab(icon: Icon(Icons.restaurant_menu), text: 'Meniu',),
                Tab(icon: Icon(Icons.table_chart), text: 'Mese',)
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
          )
        ) 
      )
    );
  }
}

class _TablesList extends StatelessWidget {
  final List<RestaurantTable> tables;

  _TablesList({Key key, this.tables}) : super(key: key);
  double _volume=0.0;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
      itemCount: tables.length,
      itemBuilder: (context, index) {
        var currentTable = tables[index];
        return Column(    
          children: <Widget>[
                 Text(currentTable.name),
                 
                 Checkbox(
                  value:false,
                  //  onChanged: (){
                                        
                  //  },
                 )
        
              ]
        );
      },
    );
  }
}

