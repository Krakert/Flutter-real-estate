// Data class used to map the JSON from the `list_houses_provider`
class HouseData {
  final int id;
  final int price;
  final String image;
  final String zip;
  final int bathrooms;
  final int bedrooms;
  final int size;
  final String city;
  final String description;
  final int latitude;
  final int longitude;
  final double distance;

  HouseData({
    required this.id,
    required this.price,
    required this.image,
    required this.zip,
    required this.bathrooms,
    required this.bedrooms,
    required this.size,
    required this.city,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.distance,
  });

  factory HouseData.fromJson(Map<String, dynamic> json) {
    return HouseData(
      id: json['id'],
      price: json['price'],
      image: json['image'],
      zip: json['zip'],
      bathrooms: json['bathrooms'],
      bedrooms: json['bedrooms'],
      size: json['size'],
      city: json['city'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      distance: 0.0
    );
  }
}
