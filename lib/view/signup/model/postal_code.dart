class PostCode {
  final int id;
  final String text;

  PostCode({required this.id, required this.text});

  factory PostCode.fromJson(Map<String, dynamic> json) {
    return PostCode(
      id: json['id'],
      text: json['text'],
    );
  }

  static List<PostCode> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PostCode.fromJson(json)).toList();
  }
}
