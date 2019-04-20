class Restaurant {
  final int id;
  final String name;
  final String description;
  final String pictureUrl;
  final String address;
  final double longitude;
  final double latitude;
  final int cityId;
  final DateTime registeredDate;

  Restaurant({this.id, this.name, this.description, this.pictureUrl, this.address, this.longitude,
              this.latitude, this.cityId, this.registeredDate});

  factory Restaurant.fromJson(Map<String, dynamic> json) { 
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureUrl: json['pictureUrl'],
      address: json['address'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      cityId: json['cityId'],
      registeredDate: DateTime.parse(json['registeredDate'])
    );
  }
}