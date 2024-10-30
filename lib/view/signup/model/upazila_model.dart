class Upazila {
  final String name;

  Upazila({required this.name});

  // Factory constructor to create an Upazila from JSON
  factory Upazila.fromJson(Map<String, dynamic> json) {
    return Upazila(name: json['name']);
  }

  // Static method to convert the response into a list of Upazila objects
  static List<Upazila> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => Upazila.fromJson(item)).toList();
  }
}
