class AttributeModel {
  final int id;
  final String name;
  final List<AttributeValue> values;

  AttributeModel({required this.id, required this.name, required this.values});

  factory AttributeModel.fromJson(Map<String, dynamic> json) {
    return AttributeModel(
      id: json['id'],
      name: json['name'],
      values: (json['values'] as List)
          .map((value) => AttributeValue.fromJson(value))
          .toList(),
    );
  }
}

class AttributeValue {
  final int id;
  final String text;
  final String color;
  final bool selected;

  AttributeValue(
      {required this.id,
      required this.text,
      required this.color,
      required this.selected});

  factory AttributeValue.fromJson(Map<String, dynamic> json) {
    return AttributeValue(
      id: json['id'],
      text: json['text'],
      color: json['color'],
      selected: json['selected'],
    );
  }
}
