// class Division {
//   final String name;

//   Division({required this.name});

//   // Factory constructor to create a Division from JSON
//   factory Division.fromJson(Map<String, dynamic> json) {
//     return Division(name: json['text']); // Match the JSON key
//   }

//   // Static method to convert the response into a list of Division objects
//   static List<Division> fromJsonList(List<dynamic> jsonList) {
//     return jsonList.map((item) => Division.fromJson(item)).toList();
//   }
// }



class Division {
  final int id;
  final String text;

  Division({required this.id, required this.text});

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      id: json['id'],
      text: json['text'],
    );
  }

  static List<Division> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Division.fromJson(json)).toList();
  }
}
