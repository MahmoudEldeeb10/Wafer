class OfferModel {
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

  const OfferModel({
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
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      offerId: json['offerId'] ?? '',
      donorOrganizationName: json['donorOrganizationName'] ?? '',
      productName: json['productName'] ?? '',
      category: json['category'] ?? 0,
      quantity: json['quantity'] ?? 0,
      productImage: json['productImage'],
      expiryDate: json['expiryDate'] ?? '',
      status: json['status'] ?? 0,
      city: json['city'],
      governorate: json['governorate'],
    );
  }
}