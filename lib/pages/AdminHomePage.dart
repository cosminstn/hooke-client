import 'package:flutter/material.dart';
import 'package:hooke/manager_pages/ConfigureRestaurantDetailsPage.dart';

class AdminHomePage extends StatefulWidget {
  static final String tag = 'admin_hud';

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {

  Widget _selectedPage = ConfigureRestaurantDetailsPage();

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> profile = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('hooke')),
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
                Navigator.of(context).pushNamed(ConfigureRestaurantDetailsPage.tag);
              },
              selected: true,
            ),
            ListTile(
              title: Text("Rezervari active", style: TextStyle(fontSize: 16)),
              leading: Icon(Icons.receipt, color: Theme.of(context).accentColor)
            ),
            ListTile(
              title: Text("Configurare meniu", style: TextStyle(fontSize: 16)),
              leading: Icon(Icons.restaurant, color: Theme.of(context).accentColor)
            ),
            ListTile(
              title: Text("Configurare mese", style: TextStyle(fontSize: 16)),
              leading: Icon(Icons.room_service, color: Theme.of(context).accentColor)
            )
          ],
        )
      ),
      body: _selectedPage
    );
  }
}