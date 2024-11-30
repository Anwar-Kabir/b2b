// models/category_model.dart
class CategoryModel {
  final int id;
  final int categorySubGroupId;
  final String name;
  final String slug;
  final String? description;
  final String icon;
  final int active;
  final int productsCount;

  CategoryModel({
    required this.id,
    required this.categorySubGroupId,
    required this.name,
    required this.slug,
    this.description,
    required this.icon,
    required this.active,
    required this.productsCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      categorySubGroupId: json['category_sub_group_id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      icon: json['icon'],
      active: json['active'],
      productsCount: json['products_count'],
    );
  }
}
