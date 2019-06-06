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
    print(json);
    return Reservation(
      id: json['id'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      endTime: DateTime.parse(json['endTime']),
      startTime: DateTime.parse(json['startTime']),
      nrOfPersons: json['nrOfPersons'],
      tableId: json['tableId'],
      orderId: json['orderId'],
      confirmed: json['confirmed']
    );
  }
}