class Category {
  final String? status;
  final CategoryGroups? data;

  Category({this.status, this.data});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      status: json['status'] as String?,
      data: json['data'] != null
          ? CategoryGroups.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.toJson(),
    };
  }
}

class CategoryGroups {
  final int? currentPage;
  final List<CategoryGroupData>? data;
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

  CategoryGroups({
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

  factory CategoryGroups.fromJson(Map<String, dynamic> json) {
    return CategoryGroups(
      currentPage: json['current_page'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) =>
              CategoryGroupData.fromJson(item as Map<String, dynamic>))
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

class CategoryGroupData {
  final int? id;
  final String? name;
  final String? slug;
  final String? description;
  final String? icon;
  final String? code;
  final String? combinedCode;
  final int? active;
  final int? order;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final int? createdBy;
  final int? updatedBy;
  final int? subGroupsCount;
  final String? coverImage;
  final String? backgroundImage;

  CategoryGroupData({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.icon,
    this.code,
    this.combinedCode,
    this.active,
    this.order,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.subGroupsCount,
    this.coverImage,
    this.backgroundImage,
  });

  factory CategoryGroupData.fromJson(Map<String, dynamic> json) {
    return CategoryGroupData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
      code: json['code'] as String?,
      combinedCode: json['combined_code'] as String?,
      active: json['active'] as int?,
      order: json['order'] as int?,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      createdBy: json['created_by'] as int?,
      updatedBy: json['updated_by'] as int?,
      subGroupsCount: json['sub_groups_count'] as int?,
      coverImage: json['cover_image'] as String?,
      backgroundImage: json['background_image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'icon': icon,
      'code': code,
      'combined_code': combinedCode,
      'active': active,
      'order': order,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'sub_groups_count': subGroupsCount,
      'cover_image': coverImage,
      'background_image': backgroundImage,
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
