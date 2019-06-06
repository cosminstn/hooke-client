import 'package:flutter/material.dart';
import 'package:hooke/manager_pages/ConfigureRestaurantDetailsPage.dart';
import 'package:hooke/manager_pages/ConfigureRestaurantTablesPage.dart';
import 'package:hooke/manager_pages/ActiveReservationsPage.dart';
import 'package:hooke/manager_pages/ConfigureRestaurantMenuPage.dart';
import 'package:hooke/manager_pages/ReservationsHistoryPage.dart';

class AdminHomePage extends StatefulWidget {
  static final String tag = 'admin_hud';

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {

  final List<Widget> pages = [
    ConfigureRestaurantDetailsPage(), 
    ActiveReservationsPage(),
    ReservationsHistoryPage(),
    ConfigureRestaurantMenuPage(),
    ConfigureRestaurantTablesPage()
  ];

  Widget _selectedPage = ConfigureRestaurantDetailsPage();
  int _selectedPageIndex = 0;

  _switchPage(int pageIndex) {
    setState(() {
      _selectedPage = pages[pageIndex];
      _selectedPageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> profile = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('hooke')
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(profile['firstName'], style: TextStyle(fontSize: 18)),
              accountEmail: Text(profile['email'], style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              title: Text("Detalii restaurant", style: TextStyle(fontSize: 16)),
              leading: Icon(Icons.info, color: Theme.of(context).accentColor),
              onTap: () {
                Navigator.of(context).pop();
                _switchPage(0);
              },
              selected: _selectedPageIndex == 0,
            ),
            ListTile(
              title: Text("Rezervari active", style: TextStyle(fontSize: 16)),
              leading: Icon(Icons.receipt, color: Theme.of(context).accentColor),
              onTap: () {
                Navigator.of(context).pop();
                _switchPage(1);
              },
              selected: _selectedPageIndex == 1
            ),
            ListTile(
              title: Text("Istoric rezervari", style: TextStyle(fontSize: 16)),
              leading: Icon(Icons.receipt, color: Theme.of(context).accentColor),
              onTap: () {
                Navigator.of(context).pop();
                _switchPage(2);
              },
              selected: _selectedPageIndex == 2
            ),
            ListTile(
              title: Text("Configurare meniu", style: TextStyle(fontSize: 16)),
              leading: Icon(Icons.restaurant, color: Theme.of(context).accentColor),
              onTap: () {
                Navigator.of(context).pop();
                _switchPage(2);
              },
              selected: _selectedPageIndex == 3
            ),
            ListTile(
              title: Text("Configurare mese", style: TextStyle(fontSize: 16)),
              leading: Icon(Icons.room_service, color: Theme.of(context).accentColor),
              onTap: () {
                Navigator.of(context).pop();
                _switchPage(3);
              },
              selected: _selectedPageIndex == 4
            )
          ],
        )
      ),
      body: _selectedPage
    );
  }
}