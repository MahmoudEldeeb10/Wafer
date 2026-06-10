class PostModel {
  final String? id;
  final String? productName;
  final String? description;
  final int? category;
  final double? quantity;
  final int? unit;
  final int? status;
  final String? createdAt;
  final String? imageUrl;
  final String? charityName;

  PostModel({
    this.id,
    this.productName,
    this.description,
    this.category,
    this.quantity,
    this.unit,
    this.status,
    this.createdAt,
    this.imageUrl,
    this.charityName,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    // charity → charityNeedId, donor → offerId
    id: (json['charityNeedId'] ?? json['offerId'])?.toString(),
    productName: json['productName'],
    description: json['description'],
    category: json['category'],
    quantity: (json['quantity'] as num?)?.toDouble(),
    unit: json['unit'],
    status: json['status'],
    createdAt: json['createdAt'],
    imageUrl: json['productImage'],
    charityName: json['charityName'],
  );
}
