// class Upazila {
//   final String name;

//   Upazila({required this.name});

//   // Factory constructor to create an Upazila from JSON
//   factory Upazila.fromJson(Map<String, dynamic> json) {
//     return Upazila(name: json['text']);
//   }

//   // Static method to convert the response into a list of Upazila objects
//   static List<Upazila> fromJsonList(List<dynamic> jsonList) {
//     return jsonList.map((item) => Upazila.fromJson(item)).toList();
//   }
// }


class Upazila {
  final int id;
  final String text;

  Upazila({required this.id, required this.text});

  factory Upazila.fromJson(Map<String, dynamic> json) {
    return Upazila(
      id: json['id'],
      text: json['text'],
    );
  }

  static List<Upazila> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Upazila.fromJson(json)).toList();
  }
}
