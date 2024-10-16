class Product {
  final int? currentPage;
  final List<ProductData>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<PageLink>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  Product({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      currentPage: json['current_page'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => ProductData.fromJson(item as Map<String, dynamic>))
          .toList(),
      firstPageUrl: json['first_page_url'] as String?,
      from: json['from'] as int?,
      lastPage: json['last_page'] as int?,
      lastPageUrl: json['last_page_url'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((item) => PageLink.fromJson(item as Map<String, dynamic>))
          .toList(),
      nextPageUrl: json['next_page_url'] as String?,
      path: json['path'] as String?,
      perPage: json['per_page'] as int?,
      prevPageUrl: json['prev_page_url'] as String?,
      to: json['to'] as int?,
      total: json['total'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': data?.map((item) => item.toJson()).toList(),
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'links': links?.map((item) => item.toJson()).toList(),
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
    };
  }
}

class ProductData {
  final int? id;
  final int? manufacturerId;
  final int? categoryId;
  final int? uomId;
  final String? name;
  final String? slug;
  final String? modelNumber;
  final String? mpn;
  final String? hsCode;
  final String? description;
  final int? minOrderQuantity;
  final bool? active;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final String? code;
  final String? combinedCode;
  final int? inventoriesCount;
  final Category? category;

  ProductData({
    this.id,
    this.manufacturerId,
    this.categoryId,
    this.uomId,
    this.name,
    this.slug,
    this.modelNumber,
    this.mpn,
    this.hsCode,
    this.description,
    this.minOrderQuantity,
    this.active,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.code,
    this.combinedCode,
    this.inventoriesCount,
    this.category,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'] as int?,
      manufacturerId: json['manufacturer_id'] as int?,
      categoryId: json['category_id'] as int?,
      uomId: json['uom_id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      modelNumber: json['model_number'] as String?,
      mpn: json['mpn'] as String?,
      hsCode: json['hs_code'] as String?,
      description: json['description'] as String?,
      minOrderQuantity: json['min_order_quantity'] as int?,
      active: json['active'] as bool?,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      code: json['code'] as String?,
      combinedCode: json['combined_code'] as String?,
      inventoriesCount: json['inventories_count'] as int?,
      category: json['category'] != null
          ? Category.fromJson(json['category'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'manufacturer_id': manufacturerId,
      'category_id': categoryId,
      'uom_id': uomId,
      'name': name,
      'slug': slug,
      'model_number': modelNumber,
      'mpn': mpn,
      'hs_code': hsCode,
      'description': description,
      'min_order_quantity': minOrderQuantity,
      'active': active,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'code': code,
      'combined_code': combinedCode,
      'inventories_count': inventoriesCount,
      'category': category?.toJson(),
    };
  }
}

class Category {
  final int? id;
  final int? categorySubGroupId;
  final String? name;
  final String? slug;
  final String? description;
  final String? icon;
  final String? code;
  final String? combinedCode;
  final int? active;
  final dynamic featured;
  final int? order;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final int? createdBy;
  final int? updatedBy;

  Category({
    this.id,
    this.categorySubGroupId,
    this.name,
    this.slug,
    this.description,
    this.icon,
    this.code,
    this.combinedCode,
    this.active,
    this.featured,
    this.order,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int?,
      categorySubGroupId: json['category_sub_group_id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
      code: json['code'] as String?,
      combinedCode: json['combined_code'] as String?,
      active: json['active'] as int?,
      featured: json['featured'],
      order: json['order'] as int?,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      createdBy: json['created_by'] as int?,
      updatedBy: json['updated_by'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_sub_group_id': categorySubGroupId,
      'name': name,
      'slug': slug,
      'description': description,
      'icon': icon,
      'code': code,
      'combined_code': combinedCode,
      'active': active,
      'featured': featured,
      'order': order,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_by': createdBy,
      'updated_by': updatedBy,
    };
  }
}

class PageLink {
  final String? url;
  final String? label;
  final bool? active;

  PageLink({
    this.url,
    this.label,
    this.active,
  });

  factory PageLink.fromJson(Map<String, dynamic> json) {
    return PageLink(
      url: json['url'] as String?,
      label: json['label'] as String?,
      active: json['active'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}
