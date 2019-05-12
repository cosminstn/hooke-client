class Table {
  final int id;
  final int restaurantId;
	final int number;
	final String name;
	
	final int maxSeats;

  Table({this.id, this.restaurantId, this.number, this.name, this.maxSeats});

/*
  {
    "id": 1,
    "maxSeats": 4,
    "name": "Masa 1",
    "number": 1,
    "restaurantId": 1,
    "userId": 2
  }
*/
  factory Table.fromJson(Map<String, dynamic> json) { 
    return Table(
      id: json['id'],
      restaurantId:json['restaurantId'],
      number: json['number'],
      name: json['name'],
      maxSeats: json['maxSeats']
    );
  }

}