import 'package:flutter/material.dart';
import 'package:hooke/pages/HomePage.dart';
import 'package:hooke/pages/PhotosPage.dart';
import 'package:hooke/pages/RestaurantDetailsPage.dart';
import 'package:hooke/pages/RestaurantsListPage.dart';


class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String username = "";
  String password = "";

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final usernameField = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: usernameController,
      decoration: 
      InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)) 
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))
      ),
    );
    
    final loginBtn = Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24)
        ),
        child: Text('Log in', style: TextStyle(color: Colors.black)),
        onPressed: () {
          // username = usernameController.text;
          // password = passwordController.text;
          print('login returned ' + login().toString());
          // if (login() == false) {
          //   return showDialog(
          //     context: context,
          //     builder: (context) {
          //       return AlertDialog(
          //         content: Text("Invalid account!")
          //       );
          //     }
          //   );
          // }
          Navigator.pushNamed(context, RestaurantDetailsPage.tag);
        },
      )
    );

    final photosBtn = Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24)
        ),
        child: Text('Photos', style: TextStyle(color: Colors.black)),
        onPressed: () {
          Navigator.pushNamed(context, PhotosPage.tag);
        },
      ));

    final restaurantsBtn = Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24)
        ),
        child: Text('restaurants', style: TextStyle(color: Colors.black)),
        onPressed: () {
          Navigator.pushNamed(context, RestaurantsListPage.tag);
        },
      ));

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            usernameField,
            passwordField,
            loginBtn,
            photosBtn,
            restaurantsBtn
          ],
          padding: EdgeInsets.all(10),
        )
      )
    );
  }

  bool login() {
    return false;
  }
}