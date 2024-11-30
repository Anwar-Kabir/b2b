class AttributeValueCreateModel {
  final int attributeId;
  final String value;
  final String color;
  final int order;

  AttributeValueCreateModel({
    required this.attributeId,
    required this.value,
    required this.color,
    required this.order,
  });

  Map<String, dynamic> toJson() {
    return {
      'attribute_id': attributeId,
      'value': value,
      'color': color,
      'order': order,
    };
  }
}
