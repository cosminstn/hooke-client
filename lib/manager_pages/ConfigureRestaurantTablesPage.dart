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
        future: Utils.instance
            .fetchRestaurantTables(Globals.currentManagerRestaurant.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            throw Exception('${snapshot.error}');
          }
          return snapshot.hasData
              ? _TablesList(tables: snapshot.data)
              : Center(child: CircularProgressIndicator());
        });
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
                  onTap: () {
                    print('Navigating to EditTablePage');
                    Navigator.pushNamed(context, EditTablePage.tag,
                        arguments: tables[index]);
                  },
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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, EditTablePage.tag, arguments: null);
          },
        ),);
  }
}
