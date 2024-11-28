// class Product {
//   final int id;
//   final int? manufacturerId;
//   final int categoryId;
//   final int uomId;
//   final String name;
//   final String slug;
//   final String? modelNumber;
//   final String? mpn;
//   final String? hsCode;
//   final String description;
//   final int minOrderQuantity;
//   final bool isActive;
//   final String createdAt;
//   final String updatedAt;
//   final String code;
//   final String combinedCode;
//   final String? featureImage;
//   final Category category;

//   Product({
//     required this.id,
//     this.manufacturerId,
//     required this.categoryId,
//     required this.uomId,
//     required this.name,
//     required this.slug,
//     this.modelNumber,
//     this.mpn,
//     this.hsCode,
//     required this.description,
//     required this.minOrderQuantity,
//     required this.isActive,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.code,
//     required this.combinedCode,
//     this.featureImage,
//     required this.category,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       manufacturerId: json['manufacturer_id'],
//       categoryId: json['category_id'],
//       uomId: json['uom_id'],
//       name: json['name'],
//       slug: json['slug'],
//       modelNumber: json['model_number'],
//       mpn: json['mpn'],
//       hsCode: json['hs_code'],
//       description: json['description'] ?? '',
//       minOrderQuantity: json['min_order_quantity'],
//       isActive: json['active'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       code: json['code'],
//       combinedCode: json['combined_code'],
//       featureImage: json['feature_image'],
//       category: Category.fromJson(json['category']),
//     );
//   }
// }

// class Category {
//   final int id;
//   final int categorySubGroupId;
//   final String name;
//   final String slug;
//   final String? description;
//   final String icon;
//   final String code;
//   final String combinedCode;
//   final bool isActive;
//   final int order;

//   Category({
//     required this.id,
//     required this.categorySubGroupId,
//     required this.name,
//     required this.slug,
//     this.description,
//     required this.icon,
//     required this.code,
//     required this.combinedCode,
//     required this.isActive,
//     required this.order,
//   });

//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       id: json['id'],
//       categorySubGroupId: json['category_sub_group_id'],
//       name: json['name'],
//       slug: json['slug'],
//       description: json['description'],
//       icon: json['icon'],
//       code: json['code'],
//       combinedCode: json['combined_code'],
//       isActive: json['active'] == 1,
//       order: json['order'],
//     );
//   }
// }




class Product {
  final int id;
  final int? manufacturerId;
  final int? categoryId;
  final int? uomId;
  final String name;
  final String slug;
  final String? modelNumber;
  final String? mpn;
  final String? hsCode;
  final String description;
  final int minOrderQuantity;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final String code;
  final String? combinedCode;
  final String? featureImage;
  final Category category;

  Product({
    required this.id,
    this.manufacturerId,
    this.categoryId,
    this.uomId,
    required this.name,
    required this.slug,
    this.modelNumber,
    this.mpn,
    this.hsCode,
    required this.description,
    required this.minOrderQuantity,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
    this.combinedCode,
    this.featureImage,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      manufacturerId: json['manufacturer_id'] as int?,
      categoryId: json['category_id'] as int?,
      uomId: json['uom_id'] as int?,
      name: json['name'] ?? 'N/A',
      slug: json['slug'] ?? '',
      modelNumber: json['model_number'],
      mpn: json['mpn'],
      hsCode: json['hs_code'],
      description: json['description'] ?? 'No description provided.',
      minOrderQuantity: json['min_order_quantity'] ?? 0,
      isActive: json['active'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      code: json['code'] ?? '',
      combinedCode: json['combined_code'],
      featureImage: json['feature_image'],
      category: Category.fromJson(json['category'] ?? {}),
    );
  }
}

class Category {
  final int id;
  final int? categorySubGroupId;
  final String name;
  final String slug;
  final String? description;
  final String icon;
  final bool isActive;
  final int? order;

  Category({
    required this.id,
    this.categorySubGroupId,
    required this.name,
    required this.slug,
    this.description,
    required this.icon,
    required this.isActive,
    this.order,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      categorySubGroupId: json['category_sub_group_id'] as int?,
      name: json['name'] ?? 'Unknown Category',
      slug: json['slug'] ?? '',
      description: json['description'],
      icon: json['icon'] ?? '',
      isActive: json['active'] == 1,
      order: json['order'] as int?,
    );
  }
}

