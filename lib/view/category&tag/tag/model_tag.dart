class Tag {
  final int id;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Tag({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}

class TagResponse {
  final int currentPage;
  final List<Tag> tags;
  final String? nextPageUrl;

  TagResponse({
    required this.currentPage,
    required this.tags,
    this.nextPageUrl,
  });

  factory TagResponse.fromJson(Map<String, dynamic> json) {
    var tagList =
        (json['data'] as List).map((tagJson) => Tag.fromJson(tagJson)).toList();
    return TagResponse(
      currentPage: json['current_page'],
      tags: tagList,
      nextPageUrl: json['next_page_url'],
    );
  }
}
