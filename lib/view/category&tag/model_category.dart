class Category {
  final int id;
  final String name;
  final String slug;
  final String? description;
  final String icon;
  final String code;
  final int active;
  final int order;
  final int subGroupsCount;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    required this.icon,
    required this.code,
    required this.active,
    required this.order,
    required this.subGroupsCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      icon: json['icon'],
      code: json['code'],
      active: json['active'],
      order: json['order'],
      subGroupsCount: json['sub_groups_count'],
    );
  }
}
