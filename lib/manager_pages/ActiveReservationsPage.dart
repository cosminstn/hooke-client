import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooke/models/Reservation.dart';
import 'package:hooke/utils/Constants.dart';
import 'package:hooke/utils/Globals.dart';
import 'package:http/http.dart' as http;

import 'ReservationsList.dart';

class ActiveReservationsPage extends StatelessWidget {

  Future<List<Reservation>> fetchActiveReservations() async {
    http.Client client = http.Client();
    final response = await client.get(Constants.API_BASE_URL + '/pub/restaurants/' + 
        Globals.currentManagerRestaurant.id.toString() + '/reservations',
        headers: {'APP_TOKEN' : Constants.APP_TOKEN});
    return compute<String, List<Reservation>>(parseReservations, response.body);
  }

  static List<Reservation> parseReservations(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Reservation>((json) => Reservation.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Reservation>>(
      future: fetchActiveReservations(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          throw Exception('${snapshot.error}');
        }
        return snapshot.hasData
            ? ReservationsList(reservations: snapshot.data)
            : Center(child: CircularProgressIndicator());
      }
    );
  }
}