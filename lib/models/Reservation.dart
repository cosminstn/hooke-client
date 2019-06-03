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

  // factory Reservation.fromJson(Map<String, dynamic> json) { 
  //   print(json);
  //   return Reservation(
  //     id: json['id'],
  //     userId: json['userId'],
  //     date: DateTime.parse(formattedString)
  //     name: json['name'],
  //     description: json['description'],
  //     maxSeats: json['maxSeats']
  //   );
  // }
}