import 'package:flutter/material.dart';
import 'package:hooke/pages/HomePage.dart';
import 'package:hooke/pages/PhotosPage.dart';
import 'package:hooke/pages/RegisterPage.dart';
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
    final logo = Padding(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 0),
      child: Text(
        "hooke",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'ComicSans', fontSize: 100, color: Colors.red),
      ),
    );

    final usernameField = Padding(
      padding: EdgeInsets.only(top: 12),
      child: TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        controller: usernameController,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
            labelText: 'Enter your username',
            hintText: 'Username',
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      )
    );

    final passwordField = Padding( 
      padding: EdgeInsets.only(top: 12),
      child: TextFormField(
        autofocus: false,
        obscureText: true,
        controller: passwordController,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
            labelText: 'Enter your password',
            hintText: 'Password',
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      )
    );

    final loginBtn = Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.red,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text('Log in',
                  style: TextStyle(color: Colors.white, fontSize: 20))),
          onPressed: () {
            username = usernameController.text;
            password = passwordController.text;
            print('login returned ' + login().toString());
            if (login() == false) {
              return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(content: Text("Invalid account!"));
                  });
            }
            Navigator.pushNamed(context, RestaurantDetailsPage.tag);
          },
        ));

    final registerBtn = Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.red,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text('Register',
                  style: TextStyle(color: Colors.white, fontSize: 20))),
          onPressed: () {
            Navigator.pushNamed(context, RegisterPage.tag);
          },
        ));

    // final photosBtn = Padding(
    //     padding: EdgeInsets.only(top: 16.0),
    //     child: RaisedButton(
    //       shape:
    //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    //       child: Text('Photos', style: TextStyle(color: Colors.black)),
    //       onPressed: () {
    //         Navigator.pushNamed(context, PhotosPage.tag);
    //       },
    //     ));

    // final restaurantsBtn = Padding(
    //     padding: EdgeInsets.only(top: 16.0),
    //     child: RaisedButton(
    //       shape:
    //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    //       child: Text('restaurants', style: TextStyle(color: Colors.black)),
    //       onPressed: () {
    //         Navigator.pushNamed(context, RestaurantsListPage.tag);
    //       },
    //     ));

    return Scaffold(
        body: Center(
            child: ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        logo,
        usernameField,
        passwordField,
        loginBtn,
        registerBtn,
        // photosBtn,
        // restaurantsBtn
      ],
      padding: EdgeInsets.all(10),
    )));
  }

  bool login() {
    return false;
  }
}
