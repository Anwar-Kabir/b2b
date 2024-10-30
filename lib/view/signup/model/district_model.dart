class District {
  final String name;

  District({required this.name});

  // Factory constructor to create a District from JSON
  factory District.fromJson(Map<String, dynamic> json) {
    return District(name: json['name']);
  }

  // Static method to convert the response into a list of District objects
  static List<District> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => District.fromJson(item)).toList();
  }
}
