
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooke/models/Reservation.dart';
import 'package:intl/intl.dart';

class ReservationsList extends StatelessWidget {

  final List<Reservation> reservations;

  ReservationsList({Key key, this.reservations}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    DateFormat timeFormat = new DateFormat('HH:mm:ss');
    DateFormat dateFormat = new DateFormat('dd MMMM yyyy');

    return Scaffold(
      body: ListView.builder(
        itemCount: reservations.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // FIXME
            },
            child: Card(
              child: Column(children: <Widget>[
                  Padding(padding: EdgeInsets.all(10),
                    child: Text(
                      'Date: ' + dateFormat.format(reservations[index].date.toLocal()),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      )
                    )
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: Text(
                        'Start: ' + timeFormat.format(reservations[index].startTime.toLocal()),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        )
                      )
                    ),
                    Expanded(
                      child: Text(
                        'End: ' + timeFormat.format(reservations[index].endTime.toLocal()),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        )
                      )
                    )
                  ],)
                ],
              )
            )
          );
        },
      )
    );
  }
}