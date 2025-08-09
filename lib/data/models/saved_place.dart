class SavedPlace {
  final String id;
  final String name;
  final String address;
  final String iconName;
  final double? latitude;
  final double? longitude;

  SavedPlace({
    required this.id,
    required this.name,
    required this.address,
    required this.iconName,
    this.latitude,
    this.longitude,
  });

  factory SavedPlace.fromJson(Map<String, dynamic> json) {
    return SavedPlace(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      iconName: json['iconName'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'iconName': iconName,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}