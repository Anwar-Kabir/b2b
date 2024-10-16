class UpdateAttributeValue {
  final int? id;
  final int? shopId;
  final int? attributeId;
  final String? value;
  final String? color;
  final int? order;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;

  UpdateAttributeValue({
    this.id,
    this.shopId,
    this.attributeId,
    this.value,
    this.color,
    this.order,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory UpdateAttributeValue.fromJson(Map<String, dynamic> json) {
    return UpdateAttributeValue(
      id: json['id'] as int?,
      shopId: json['shop_id'] as int?,
      attributeId: json['attribute_id'] as int?,
      value: json['value'] as String?,
      color: json['color'] as String?,
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
      'attribute_id': attributeId,
      'value': value,
      'color': color,
      'order': order,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class AttributeValueModel {
  final UpdateAttributeValue? attributeValue;

  AttributeValueModel({this.attributeValue});

  factory AttributeValueModel.fromJson(Map<String, dynamic> json) {
    return AttributeValueModel(
      attributeValue: json['attributeValue'] != null
          ? UpdateAttributeValue.fromJson(json['attributeValue'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attributeValue': attributeValue?.toJson(),
    };
  }
}
