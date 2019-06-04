import 'package:flutter/material.dart';
import 'package:hooke/pages/RestaurantDetailsPage.dart';
import 'package:hooke/pages/PhotosPage.dart';

import 'RestaurantsListPage.dart';
//import 'package:hooke/models/Restaurant.dart';

class RestaurantHomePage extends StatefulWidget {
  static final String tag = 'homepage1';

  @override
  _RestaurantHomePageState createState() => _RestaurantHomePageState();
}


class _RestaurantHomePageState extends State<RestaurantHomePage> {
  final List<Widget> pages = [RestaurantsListPage(),
                             PhotosPage()];

  Widget _selectedPage = RestaurantsListPage();
  int _selectedPageIndex = 0;

  _switchPage(int pageIndex) {
    setState(() {
       _selectedPageIndex = pageIndex;
      _selectedPage = pages[pageIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
   //   final Restaurant restaurant = ModalRoute.of(context).settings.arguments;
    final Map<String, dynamic> profile =
        ModalRoute.of(context).settings.arguments;

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
                        icon: Icon(Icons.restaurant_menu),
                        text: 'Meniu',
                      ),
                      Tab(
                        icon: Icon(Icons.table_chart),
                        text: 'Mese',
                      )
                    ],
                  ),
                  title: Text("Hooke"),
                ),
                drawer: Drawer(
                    child: ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text(profile['firstName'],
                          style: TextStyle(fontSize: 18)),
                      accountEmail: Text(profile['email'],
                          style: TextStyle(fontSize: 16)),
                    ),
                    ListTile(
                        title: Text("Lista restaurante",
                            style: TextStyle(fontSize: 16)),
                        leading: Icon(Icons.restaurant,
                            color: Theme.of(context).accentColor),
                        onTap: () {
                         // Navigator.of(context).pop();
                          _switchPage(0);
                        },
                        selected: _selectedPageIndex == 0),
                    ListTile(
                        title: Text("Istoric comenzi",
                            style: TextStyle(fontSize: 16)),
                        leading: Icon(Icons.history,
                            color: Theme.of(context).accentColor),
                        onTap: () {
                          Navigator.of(context).pop();
                          _switchPage(0);
                        },
                        selected: _selectedPageIndex == 0),
                    ListTile(
                        title: Text("Log out", style: TextStyle(fontSize: 16)),
                        leading: Icon(Icons.settings,
                            color: Theme.of(context).accentColor),
                        onTap: () {
                          Navigator.of(context).pop();
                          //_switchPage(0);
                        },
                        selected: _selectedPageIndex == 0)
                  ],
                )),
                body: _selectedPage)));
  }
  
}
