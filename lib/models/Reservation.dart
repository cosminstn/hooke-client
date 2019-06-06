import 'package:intl/intl.dart';

class Reservation {
  final int id;
	final int userId;
	final DateTime date;
	final DateTime startTime;
	final DateTime endTime;
	final int nrOfPersons;
	final int tableId;
	final int orderId;
  final bool confirmed;

  Reservation ({this.id, this.userId, this.date, this.startTime, this.endTime, this.nrOfPersons, 
                this.tableId, this.orderId, this.confirmed});

  factory Reservation.fromJson(Map<String, dynamic> json) { 
    print(json['date'] + 'T' + json['endTime'] + 'Z');
    return Reservation(
      id: json['id'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      endTime: DateTime.parse(json['date'] + 'T' + json['endTime'] + 'Z'),
      startTime: DateTime.parse(json['date'] + 'T' + json['startTime'] + 'Z'),
      nrOfPersons: json['nrOfPersons'],
      tableId: json['tableId'],
      orderId: json['orderId'],
      confirmed: json['confirmed']
    );
  }
}