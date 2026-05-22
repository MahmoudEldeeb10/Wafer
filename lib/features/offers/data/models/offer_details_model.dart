class OfferDetailsModel {
  final String offerId;
  final String donorOrganizationName;
  final String productName;
  final int category;
  final int quantity;
  final String? productImage;
  final String expiryDate;
  final int status;
  final String? city;
  final String? governorate;
  final String? description;
  final String? phone;
  final String? address;

  const OfferDetailsModel({
    required this.offerId,
    required this.donorOrganizationName,
    required this.productName,
    required this.category,
    required this.quantity,
    this.productImage,
    required this.expiryDate,
    required this.status,
    this.city,
    this.governorate,
    this.description,
    this.phone,
    this.address,
  });

  factory OfferDetailsModel.fromJson(Map<String, dynamic> json) {
    return OfferDetailsModel(
      offerId: json['offerId'] ?? '',
      donorOrganizationName: json['donorOrganizationName'] ?? '',
      productName: json['productName'] ?? '',
      category: (json['category'] as num?)?.toInt() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      productImage: json['productImage'],
      expiryDate: json['expiryDate'] ?? '',
      status: (json['status'] as num?)?.toInt() ?? 0,
      city: json['city'],
      governorate: json['governorate'],
      description: json['description'],
      phone: json['phone'],
      address: json['address'],
    );
  }
}
