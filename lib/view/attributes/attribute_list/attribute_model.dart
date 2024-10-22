
class Attribute {
  final int? id;
  final String? name;
  final String? categories;
  final int? attributeValueCount;

  Attribute({
    required this.id,
    required this.name,
    required this.categories,
    required this.attributeValueCount,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      id: json['id'] as int?,
      name: json['name'] as String?,
      categories: json['categories'] as String?,
      attributeValueCount: json['attribute_value_count'] as int?,
    );
  }
}

class AttributeResponse {
  final List<Attribute>? attributes;

  AttributeResponse({required this.attributes});

  factory AttributeResponse.fromJson(Map<String, dynamic> json) {
    return AttributeResponse(
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((i) => Attribute.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}
