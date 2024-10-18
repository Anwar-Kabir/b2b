class Product {
  int id;
  String? name; // Make this nullable
  String? subSubCategory; // Make this nullable
  String? featureImage; // Make this nullable

  Product({
    required this.id,
    this.name,
    this.subSubCategory,
    this.featureImage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'], // Can be null
      subSubCategory: json['sub_sub_category'], // Can be null
      featureImage: json['feature_image'], // Can be null
    );
  }
}
