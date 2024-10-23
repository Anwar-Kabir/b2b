class Upazila {
  final String name;

  Upazila({required this.name});

  factory Upazila.fromJson(Map<String, dynamic> json) {
    return Upazila(name: json['name']);
  }

  static List<Upazila> fromJsonList(Map<String, dynamic> json) {
    return json.keys.map((key) => Upazila(name: key)).toList();
  }
}
