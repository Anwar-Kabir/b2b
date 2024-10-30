// models/product.dart
class InventoryActiveModel {
  final int id;
  final String name;
  final String salePrice;
  final String featureImage;
  final dynamic netPrice;

  InventoryActiveModel({
    required this.id,
    required this.name,
    required this.salePrice,
    required this.featureImage,
    required this.netPrice,
  });

  factory InventoryActiveModel.fromJson(Map<String, dynamic> json) {
    return InventoryActiveModel(
      id: json['id'],
      name: json['name'],
      salePrice: json['sale_price'],
      featureImage: json['feature_image'],
      netPrice: json['net_price'],
    );
  }
}



 