import 'package:flutter/material.dart';
import 'package:hooke/manager_pages/AdminHomePage.dart';
import 'package:hooke/pages/HomePage.dart';
import 'package:hooke/pages/LoginPage.dart';
import 'package:hooke/pages/PhotosPage.dart';
import 'package:hooke/pages/RegisterPage.dart';
import 'package:hooke/pages/RestaurantDetailsPage.dart';
import 'package:hooke/pages/RestaurantsListPage.dart';
import 'package:hooke/manager_pages/EditTablePage.dart';

class Routes {

  static final routes = <String, WidgetBuilder> {
      LoginPage.tag: (context) => LoginPage(),
      RegisterPage.tag: (context) => RegisterPage(),
      HomePage.tag:  (context) => HomePage(),
      RestaurantDetailsPage.tag: (context) => RestaurantDetailsPage(),
      PhotosPage.tag: (context) => PhotosPage(),
      RestaurantsListPage.tag: (context) => RestaurantsListPage(),
      AdminHomePage.tag: (context) => AdminHomePage(),
      EditTablePage.tag: (context) => EditTablePage(),
      '/logout':     (context) => LoginPage()
    };

}