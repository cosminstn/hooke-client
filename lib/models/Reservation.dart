class Reservation {
  int id;
	int userId;
	DateTime date;
	DateTime startTime;
	DateTime endTime;
	int nrOfPersons;
	int tableId;
	int orderId;
  bool confirmed;

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

  Map toJson() => {
    'userId': userId,
    'date': date,
    'endTime': endTime,
    'startTime': startTime,
    'nrOfPersons': nrOfPersons,
    'tableId': tableId
  };
}