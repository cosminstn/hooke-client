import 'package:flutter/material.dart';
import 'package:hooke/models/Restaurant.dart';
import 'dart:async';
import 'package:hooke/pages/RestaurantDetailsPage.dart';

class RestaurantHomePage extends StatefulWidget{
    static final String tag = "homepage1";
  _BasicRestaurantHomePage createState()=> _BasicRestaurantHomePage();
}
class _BasicRestaurantHomePage extends State<RestaurantHomePage> {

    Widget _selectedPage;
    // _switchPage(int pageIndex) {
    //   setState(() {
    //     _selectedPage = pages[pageIndex];
    //     _selectedPageIndex = pageIndex;
    //   });
    // }
   
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hooke"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Cauta restaurant"),
              trailing: Icon(Icons.arrow_forward),

              onTap: () {
                Navigator.of(context).pop();
                
              }
                 
            ),
            ListTile(
              title: Text("Rezervare"),
              trailing: Icon(Icons.arrow_forward),
             
              
            ),
             ListTile(
              title: Text("Anuleaza"),
              trailing: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
      body: _selectedPage
      //this will just add the Navigation Drawer Icon
    );
  }
//   @override}
}








// void main() {
//   runApp(BasicAppBarSample());
// }

// UserAccountsDrawerHeader(
//   accountName: Text("Ashish Rawat"),
//   accountEmail: Text("ashishrawat2911@gmail.com"),
//   currentAccountPicture: CircleAvatar(
//     backgroundColor:
//         Theme.of(context).platform == TargetPlatform.iOS
//             ? Colors.blue
//             : Colors.white,
//     child: Text(
//       "A",
//       style: TextStyle(fontSize: 40.0),
//     ),
//   ),
// ),
