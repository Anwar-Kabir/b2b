class Division {
  final String name;

  Division({required this.name});

  factory Division.fromJson(String key, dynamic value) {
    return Division(name: value);
  }

  static List<Division> fromJsonList(Map<String, dynamic> json) {
    return json.entries
        .map((entry) => Division.fromJson(entry.key, entry.value))
        .toList();
  }
}
