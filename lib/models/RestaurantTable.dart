class RestaurantTable {
  final int id;
  final int restaurantId;
	final int number;
	final String name;
	final String description;
	final int maxSeats;

  RestaurantTable({this.id, this.restaurantId, this.number, this.name, this.description, this.maxSeats});

  factory RestaurantTable.fromJson(Map<String, dynamic> json) { 
    return RestaurantTable(
      id: int.parse(json['id']),
      restaurantId: int.parse(json['restaurantId']),
      number: int.parse(json['number']),
      name: json['name'],
      description: json['description'],
      maxSeats: json['maxSeats']
    );
  }

}