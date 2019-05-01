import 'dart:convert';

import 'package:hooke/utils/Constants.dart';

class Utils {

  static bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email);
  }

  static String createAuthToken(String username, String password) {
    String finalToken = Constants.AUTH_HEADER_PREFIX;
    String token = username + ':' + password;
    var bytes = utf8.encode(token);
    finalToken += base64.encode(bytes);
    return finalToken;
  }
}