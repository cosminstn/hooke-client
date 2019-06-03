import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hooke/models/Restaurant.dart';
import 'package:hooke/models/RestaurantTable.dart';
import 'package:hooke/utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'Globals.dart';


class Utils {

  Utils._privateConstructor();

  static final Utils _instance = Utils._privateConstructor();

  static Utils get instance { return _instance; }

  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email);
  }

  String createAuthToken(String username, String password) {
    String finalToken = Constants.AUTH_HEADER_PREFIX;
    String token = username + ':' + password;
    var bytes = utf8.encode(token);
    finalToken += base64.encode(bytes);
    return finalToken;
  }

  Future<Restaurant> fetchRestaurantByCreator() async {
    try {
      http.Client client = http.Client();
      final response = await client
          .get(Constants.API_BASE_URL + '/pub/restaurants/bycreator', headers: {
        'APP_TOKEN': Constants.APP_TOKEN,
        'Authorization': Globals.authToken
      }).timeout(Duration(seconds: 3));
    
      return Restaurant.fromJson(json.decode(response.body));
    } catch (ex) {
      return null;
    }
  }
  
  Future<List<RestaurantTable>> fetchRestaurantTables(int restaurantId) async {
    http.Client client = http.Client();
    final response = await client.get(Constants.API_BASE_URL + '/pub/restaurants/' + restaurantId.toString() 
                                      + '/tables',
                                      headers: {'APP_TOKEN' : Constants.APP_TOKEN});
    return compute<String, List<RestaurantTable>>(parseTables, response.body);
  }

  static List<RestaurantTable> parseTables(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<RestaurantTable>((json) => RestaurantTable.fromJson(json)).toList();
  }
}