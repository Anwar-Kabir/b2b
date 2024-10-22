class BannerResponse {
  bool success;
  String message;
  BannerData data;

  BannerResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BannerResponse.fromJson(Map<String, dynamic> json) {
    return BannerResponse(
      success: json['success'],
      message: json['message'],
      data: BannerData.fromJson(json['data']),
    );
  }
}

class BannerData {
  int currentPage;
  List<BannerItem> banners;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<PageLink> links;
  String? nextPageUrl;
  String path;
  int perPage;
  String? prevPageUrl;
  int to;
  int total;

  BannerData({
    required this.currentPage,
    required this.banners,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) {
    return BannerData(
      currentPage: json['current_page'],
      banners:
          (json['data'] as List).map((i) => BannerItem.fromJson(i)).toList(),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: (json['links'] as List).map((i) => PageLink.fromJson(i)).toList(),
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
}

class BannerItem {
  int id;
  int shopId;
  String title;
  String description;
  String? link;
  String? linkLabel;
  String bgColor;
  int columns;
  int order;
  bool effect;
  String createdAt;
  String updatedAt;
  dynamic createdBy;
  dynamic updatedBy;

  BannerItem({
    required this.id,
    required this.shopId,
    required this.title,
    required this.description,
    this.link,
    this.linkLabel,
    required this.bgColor,
    required this.columns,
    required this.order,
    required this.effect,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      id: json['id'],
      shopId: json['shop_id'],
      title: json['title'],
      description: json['description'],
      link: json['link'],
      linkLabel: json['link_label'],
      bgColor: json['bg_color'],
      columns: json['columns'],
      order: json['order'],
      effect: json['effect'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
    );
  }
}

class PageLink {
  String? url;
  String label;
  bool active;

  PageLink({
    this.url,
    required this.label,
    required this.active,
  });

  factory PageLink.fromJson(Map<String, dynamic> json) {
    return PageLink(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
}
