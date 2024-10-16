class CategoryGroup {
  final Map<String, Map<String, String>>? categories;

  CategoryGroup({this.categories});

  factory CategoryGroup.fromJson(Map<String, dynamic> json) {
    return CategoryGroup(
      categories: json.map((key, value) =>
          MapEntry(key, Map<String, String>.from(value as Map))),
    );
  }

  Map<String, dynamic> toJson() {
    return categories?.map((key, value) => MapEntry(key, value)) ?? {};
  }
}
