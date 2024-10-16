class SingleAttribute {
  final int? id;
  final int? shopId;
  final String? name;
  final int? order;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;

  SingleAttribute({
    this.id,
    this.shopId,
    this.name,
    this.order,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory SingleAttribute.fromJson(Map<String, dynamic> json) {
    return SingleAttribute(
      id: json['id'] as int?,
      shopId: json['shop_id'] as int?,
      name: json['name'] as String?,
      order: json['order'] as int?,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shop_id': shopId,
      'name': name,
      'order': order,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Category {
  final Map<String, Map<String, String>>? categories;

  Category({this.categories});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categories: (json as Map<String, dynamic>?)?.map((key, value) =>
          MapEntry(key, Map<String, String>.from(value as Map))),
    );
  }

  Map<String, dynamic> toJson() {
    return categories?.map((key, value) => MapEntry(key, value)) ?? {};
  }
}

class DataModel {
  final SingleAttribute? attribute;
  final Category? categories;

  DataModel({
    this.attribute,
    this.categories,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      attribute: json['attribute'] != null
          ? SingleAttribute.fromJson(json['attribute'] as Map<String, dynamic>)
          : null,
      categories: json['categories'] != null
          ? Category.fromJson(json['categories'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attribute': attribute?.toJson(),
      'categories': categories?.toJson(),
    };
  }
}
