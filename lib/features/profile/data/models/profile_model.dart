class ProfileModel {
  final String? userName;
  final String? email;
  final String? phone;
  final String? whatsapp;
  final String? city;
  final String? governorate;
  final String? postalCode;
  final String? imageUrl;
  final double? latitude;
  final double? longitude;
  final int? role;
  final int? verificationState;
  final bool? isActive;
  final CharityDetails? charityDetails;

  ProfileModel({
    this.userName,
    this.email,
    this.phone,
    this.whatsapp,
    this.city,
    this.governorate,
    this.postalCode,
    this.imageUrl,
    this.latitude,
    this.longitude,
    this.role,
    this.verificationState,
    this.isActive,
    this.charityDetails,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    userName: json['userName'],
    email: json['email'],
    phone: json['phone'],
    whatsapp: json['whatsapp'],
    city: json['city'],
    governorate: json['governorate'],
    postalCode: json['postalCode'],
    imageUrl: json['imageUrl'],
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
    role: (json['role'] as num?)?.toInt(),
    verificationState: (json['verificationState'] as num?)?.toInt(),
    isActive: json['isActive'],
    charityDetails: json['charityDetails'] != null
        ? CharityDetails.fromJson(json['charityDetails'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'email': email,
    'phone': phone,
    'whatsapp': whatsapp,
    'city': city,
    'governorate': governorate,
    'postalCode': postalCode,
  };
}

class CharityDetails {
  final String? charityName;
  final String? charityDescription;
  final String? registrationNumber;
  final String? headquartersAddress;
  final String? authorizedPersonName;
  final String? authorizedPersonPosition;

  CharityDetails({
    this.charityName,
    this.charityDescription,
    this.registrationNumber,
    this.headquartersAddress,
    this.authorizedPersonName,
    this.authorizedPersonPosition,
  });

  factory CharityDetails.fromJson(Map<String, dynamic> json) => CharityDetails(
    charityName: json['charityName'],
    charityDescription: json['charityDescription'],
    registrationNumber: json['registrationNumber'],
    headquartersAddress: json['headquartersAddress'],
    authorizedPersonName: json['authorizedPersonName'],
    authorizedPersonPosition: json['authorizedPersonPosition'],
  );
}
