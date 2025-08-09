class Driver {
  final String id;
  final String name;
  final String carModel;
  final double rating;
  final double price;
  final int eta;

  Driver({
    required this.id,
    required this.name,
    required this.carModel,
    required this.rating,
    required this.price,
    required this.eta,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        carModel: json['carModel'] as String? ?? '',
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        eta: (json['eta'] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'carModel': carModel,
        'rating': rating,
        'price': price,
        'eta': eta,
      };
}