// class InventoryActiveModel {
//   final int id;
//   final String name;
//   final String salePrice;
//   final int stockQuantity;
//   final int moq;
//   final String createdAt;

//   InventoryActiveModel({
//     required this.id,
//     required this.name,
//     required this.salePrice,
//     required this.stockQuantity,
//     required this.moq,
//     required this.createdAt,
//   });

//   factory InventoryActiveModel.fromJson(Map<String, dynamic> json) {
//     return InventoryActiveModel(
//       id: json['id'],
//       name: json['name'],
//       salePrice: json['sale_price'],
//       stockQuantity: json['stock_quantity'],
//       moq: json['moq'],
//       createdAt: json['created_at'],
//     );
//   }
// }




 
 class InventoryActiveModel {
  final int id;
  final String name;
  final String salePrice;
  final int stockQuantity;
  final int moq;
  final String createdAt;
  final String uom;
  final String image;

  InventoryActiveModel({
    required this.id,
    required this.name,
    required this.salePrice,
    required this.stockQuantity,
    required this.moq,
    required this.createdAt,
    required this.uom,
    required this.image,
  });

  factory InventoryActiveModel.fromJson(Map<String, dynamic> json) {
    return InventoryActiveModel(
      id: json['id'],
      name: json['name'],
      salePrice: json['sale_price'],
      stockQuantity: json['stock_quantity'],
      moq: json['moq'],
      createdAt: json['created_at'],
      uom: json['uom'],
      image: json['image'],
    );
  }
}
