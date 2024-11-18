class BannerModel {
  String? title;
  String? link;
  String? linkLabel;
  String? bgColor;
  String? columns;
  String? order;
  bool? effect;
  int? shopId;
  String? featureImage;  
  DateTime? createdAt;
  DateTime? updatedAt;
  int? id;
  String? description; 

  BannerModel({
    this.title,
    this.link,
    this.linkLabel,
    this.bgColor,
    this.columns,
    this.order,
    this.effect,
    this.shopId,
    this.featureImage,
    this.createdAt,
    this.updatedAt,
    this.id,
     this.description,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      title: json['title'],
      link: json['link'],
      linkLabel: json['link_label'],
      bgColor: json['bg_color'],
      columns: json['columns'],
      description: json['description'],
      order: json['order'],
      effect: json['effect'],
      shopId: json['shop_id'],
      featureImage: json['feature_image'],  
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'link': link,
      'link_label': linkLabel,
      'bg_color': bgColor,
      'columns': columns,
      'description': description,
      'order': order,
      'effect': effect,
      'shop_id': shopId,
      'feature_image': featureImage,  
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'id': id,
    };
  }
}
