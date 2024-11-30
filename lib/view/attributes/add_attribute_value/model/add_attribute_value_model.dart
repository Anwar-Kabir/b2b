class AttributeValueModel {
  final int id;
  final String name;
  final String categories;
  final int attributeValueCount;

  AttributeValueModel({
    required this.id,
    required this.name,
    required this.categories,
    required this.attributeValueCount,
  });

  // Factory method to create an Attribute from JSON
  factory AttributeValueModel.fromJson(Map<String, dynamic> json) {
    return AttributeValueModel(
      id: json['id'],
      name: json['name'],
      categories: json['categories'],
      attributeValueCount: json['attribute_value_count'],
    );
  }
}





