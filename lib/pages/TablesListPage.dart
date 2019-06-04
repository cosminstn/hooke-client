import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooke/utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:hooke/models/RestaurantTable.dart';
import 'package:hooke/utils/Globals.dart';

Future<List<RestaurantTable>> fetchTables(int restaurantId) async {
  http.Client client = http.Client();
  final response = await client.get(
      Constants.API_BASE_URL + '/pub/restaurants/' + restaurantId.toString() + '/tables',
      headers: {'APP_TOKEN': Constants.APP_TOKEN});
  return compute<String, List<RestaurantTable>>(parseTables, response.body);
}

List<RestaurantTable> parseTables(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<RestaurantTable>((json) => RestaurantTable.fromJson(json)).toList();
}

class TablesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista mese'),
        ),
        body: FutureBuilder<List<RestaurantTable>>(
            future: fetchTables(Globals.currentManagerRestaurant.id),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                throw Exception('${snapshot.error}');
              }
              return snapshot.hasData
                  ? _TablesList(tables: snapshot.data)
                  : Center(child: CircularProgressIndicator());
            }));
  }
}

class _TablesList extends StatelessWidget {
  final List<RestaurantTable> tables;

  _TablesList({Key key, this.tables}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.tables.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // TODO: Implement tables details
            //Navigator.pushNamed(context, RestaurantDetailsPage.tag, arguments: restaurants[index]);
          },
          child: Card(
            color: Theme.of(context).primaryColorLight,
            child: Theme(
                data: Theme.of(context).copyWith(cardColor: Colors.red),
                child: Column(
                  children: <Widget>[
                    Text(
                      tables[index].description,
                    ),
                    Text(
                      'Nr. masa: ' + tables[index].number.toString(),
                      style: TextStyle(fontStyle: FontStyle.italic)
                    ),
                    Text(
                      'Nr. locuri: ' + tables[index].maxSeats.toString(),
                      style: TextStyle(fontStyle: FontStyle.italic)
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                )
              )
          )
        );
      },
    );
  }
}