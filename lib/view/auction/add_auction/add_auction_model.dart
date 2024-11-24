class AddAuctionModel {
  int? productId;
  String? sku;
  bool? active;
  List<String>? keyFeatures;
  double? salePrice;
  int? stockQuantity;
  String? description;
  List<String>? bulkImages;
  DateTime? auctionDate;
  DateTime? registrationLastDate;

  AddAuctionModel({
    this.productId,
    this.sku,
    this.active,
    this.keyFeatures,
    this.salePrice,
    this.stockQuantity,
    this.description,
    this.bulkImages,
    this.auctionDate,
    this.registrationLastDate,
  });

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "sku": sku,
      "active":
          active == true ? 1 : 0, // Convert bool to int for JSON compatibility
      "key_features": keyFeatures ?? [],
      "sale_price": salePrice,
      "stock_quantity": stockQuantity,
      "description": description,
      "bluck_image": bulkImages ?? [],
      "auction_date":
          auctionDate?.toIso8601String(), // Convert DateTime to String
      "registration_last_date":
          registrationLastDate?.toIso8601String(), // Convert DateTime to String
    };
  }

  // Convert JSON to the model
  static AddAuctionModel fromJson(Map<String, dynamic> json) {
    return AddAuctionModel(
      productId: json['product_id'] ,
      sku: json['sku'] as String?,
      active: json['active'] == 1, // Convert int to bool
      keyFeatures: List<String>.from(json['key_features'] ?? []),
      salePrice: (json['sale_price'] as num?)?.toDouble(),
      stockQuantity: json['stock_quantity'] as int?,
      description: json['description'] as String?,
      bulkImages: List<String>.from(json['bluck_image'] ?? []),
      auctionDate: json['auction_date'] != null
          ? DateTime.parse(json['auction_date']) // Parse String to DateTime
          : null,
      registrationLastDate: json['registration_last_date'] != null
          ? DateTime.parse(
              json['registration_last_date']) // Parse String to DateTime
          : null,
    );
  }
}
