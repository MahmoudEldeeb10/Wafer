class ReceivedApplicationModel {
  final String needApplicationId;
  final int charityNeedStatus;
  final String charityNeedId;
  final String productName;
  final String donorOrganizationId;
  final String donorOrganizationName;
  final double quantity;
  final int unit;
  final int status;
  final String email;
  final String phone;
  final String whatsapp;
  final String city;
  final String governorate;
  final String donorOrganizationDescription;
  final String needDescription;
  final String productImage;
  final String createdAt;

  const ReceivedApplicationModel({
    required this.needApplicationId,
    required this.charityNeedStatus,
    required this.charityNeedId,
    required this.productName,
    required this.donorOrganizationId,
    required this.donorOrganizationName,
    required this.quantity,
    required this.unit,
    required this.status,
    required this.email,
    required this.phone,
    required this.whatsapp,
    required this.city,
    required this.governorate,
    required this.donorOrganizationDescription,
    required this.needDescription,
    required this.productImage,
    required this.createdAt,
  });

  ReceivedApplicationModel copyWith({int? charityNeedStatus, int? status}) {
    return ReceivedApplicationModel(
      needApplicationId: needApplicationId,
      charityNeedStatus: charityNeedStatus ?? this.charityNeedStatus,
      charityNeedId: charityNeedId,
      productName: productName,
      donorOrganizationId: donorOrganizationId,
      donorOrganizationName: donorOrganizationName,
      quantity: quantity,
      unit: unit,
      status: status ?? this.status,
      email: email,
      phone: phone,
      whatsapp: whatsapp,
      city: city,
      governorate: governorate,
      donorOrganizationDescription: donorOrganizationDescription,
      needDescription: needDescription,
      productImage: productImage,
      createdAt: createdAt,
    );
  }

  // factory ReceivedApplicationModel.fromJson(Map<String, dynamic> json) {
  //   return ReceivedApplicationModel(
  //     needApplicationId: json['needApplicationId'] ?? '',
  //     charityNeedStatus: json['charityNeedStatus'] ?? 0,
  //     charityNeedId: json['charityNeedId'] ?? '',
  //     productName: json['productName'] ?? '',
  //     donorOrganizationId: json['donorOrganizationId'] ?? '',
  //     donorOrganizationName: json['donorOrganizationName'] ?? '',
  //     quantity: (json['quantity'] as num).toDouble(),
  //     unit: json['unit'] ?? 0,
  //     status: json['status'] ?? 0,
  //     email: json['email'] ?? '',
  //     phone: json['phone'] ?? '',
  //     whatsapp: json['whatsapp'] ?? '',
  //     city: json['city'] ?? '',
  //     governorate: json['governorate'] ?? '',
  //     donorOrganizationDescription: json['donorOraganizationDesctption'] ?? '',
  //     needDescription: json['needDescription'] ?? '',
  //     productImage: json['productImage'] ?? '',
  //     createdAt: json['createdAt'] ?? '',
  //   );
  // }

  factory ReceivedApplicationModel.fromJson(
    Map<String, dynamic> json, {
    String idKey = 'needApplicationId',
  }) {
    return ReceivedApplicationModel(
      needApplicationId: json[idKey] ?? '',
      // باقي الـ fields كما هي
      charityNeedStatus: json['charityNeedStatus'] ?? 0,
      charityNeedId: json['charityNeedId'] ?? '',
      productName: json['productName'] ?? '',
      donorOrganizationId: json['donorOrganizationId'] ?? '',
      donorOrganizationName: json['donorOrganizationName'] ?? '',
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'] ?? 0,
      status: json['status'] ?? 0,
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      whatsapp: json['whatsapp'] ?? '',
      city: json['city'] ?? '',
      governorate: json['governorate'] ?? '',
      donorOrganizationDescription: json['donorOraganizationDesctption'] ?? '',
      needDescription: json['needDescription'] ?? '',
      productImage: json['productImage'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
