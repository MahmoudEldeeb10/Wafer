class CharityNeedModel {
  final String charityNeedId;
  final String charityName;
  final String productName;
  final int category;
  final String? city;
  final String? governorate;
  final int quantity;
  final int unit;
  final int priority;
  final int status;
  final String createdAt;
  final String? email;
  final String? phone;
  final String? whatsapp;
  final String? description;
  final String? charityDescription;
  final String? productImage;
  final double? latitude;
  final double? longitude;

  const CharityNeedModel({
    required this.charityNeedId,
    required this.charityName,
    required this.productName,
    required this.category,
    this.city,
    this.governorate,
    required this.quantity,
    required this.unit,
    required this.priority,
    required this.status,
    required this.createdAt,
    this.email,
    this.phone,
    this.whatsapp,
    this.description,
    this.charityDescription,
    this.productImage,
    this.latitude,
    this.longitude,
  });

  factory CharityNeedModel.fromJson(Map<String, dynamic> json) {
    return CharityNeedModel(
      charityNeedId: json['charityNeedId'] ?? '',
      charityName: json['charityName'] ?? '',
      productName: json['productName'] ?? '',
      category: (json['category'] as num?)?.toInt() ?? 0,
      city: json['city'],
      governorate: json['governorate'],
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      unit: (json['unit'] as num?)?.toInt() ?? 0,
      priority: (json['priority'] as num?)?.toInt() ?? 0,
      status: (json['status'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] ?? '',
      email: json['email'],
      phone: json['phone'],
      whatsapp: json['whatsapp'],
      description: json['description'],
      charityDescription: json['charityDescription'],
      productImage: json['productImage'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }
}
