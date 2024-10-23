class District {
  final String name;

  District({required this.name});

  // Factory constructor to create a District from JSON
  factory District.fromJson(String name) {
    return District(name: name);
  }

  // Static method to convert the response into a list of District objects
  static List<District> fromJsonList(Map<String, dynamic> json) {
    return json.entries.map((entry) {
      return District(name: entry.value);
    }).toList();
  }
}
