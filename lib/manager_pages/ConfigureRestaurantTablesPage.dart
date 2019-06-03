
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooke/models/RestaurantTable.dart';
import 'package:hooke/utils/Globals.dart';
import 'package:hooke/utils/Utils.dart';

import 'EditTablePage.dart';



class ConfigureRestaurantTablesPage extends StatelessWidget {
  
  static String tag = 'configure-tables';
  ConfigureRestaurantTablesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RestaurantTable>>(
      future: Utils.instance.fetchRestaurantTables(Globals.currentManagerRestaurant.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          throw Exception('${snapshot.error}');
        }
        return snapshot.hasData ? _TablesList(tables: snapshot.data) : Center(child: CircularProgressIndicator());
      }
    );
  }  
}

class _TablesList extends StatelessWidget {

  final List<RestaurantTable> tables;

  _TablesList({Key key, this.tables}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tables.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, EditTablePage.tag, arguments: tables[index]);
          },
          child: Card(
            color: Theme.of(context).primaryColorLight,
            child: Theme(
              data: Theme.of(context).copyWith(cardColor: Colors.red),
              child: Column(
                children: <Widget>[
                  Text(tables[index].name),
                  Text('Nr. :' + tables[index].number.toString())
                ],
                crossAxisAlignment: CrossAxisAlignment.start
              )
          )
          )
        );
      }
    );
  }

}