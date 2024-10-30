class Division {
  final String name;

  Division({required this.name});

  // Factory constructor to create a Division from JSON
  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(name: json['name']);
  }

  // Static method to convert the response into a list of Division objects
  static List<Division> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => Division.fromJson(item)).toList();
  }
}
