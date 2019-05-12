class Table {
  final int id;
  final int restaurantId;
	final int number;
	final String name;
	final String description;
	final int maxSeats;

  Table({this.id, this.restaurantId, this.number, this.name, this.description, this.maxSeats});

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
      id: int.parse(json['id']),
      restaurantId: int.parse(json['restaurantId']),
      number: int.parse(json['number']),
      name: json['name'],
      description: json['description']
    );
  }

}