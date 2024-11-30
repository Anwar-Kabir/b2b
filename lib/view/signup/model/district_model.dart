// class District {
//   final String name;

//   District({required this.name});

//   // Factory constructor to create a District from JSON
//   factory District.fromJson(Map<String, dynamic> json) {
//     return District(name: json['text']);
//   }

//   // Static method to convert the response into a list of District objects
//   static List<District> fromJsonList(List<dynamic> jsonList) {
//     return jsonList.map((item) => District.fromJson(item)).toList();
//   }
// }



class District {
  final int id;
  final String text;

  District({required this.id, required this.text});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'],
      text: json['text'],
    );
  }

  static List<District> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => District.fromJson(json)).toList();
  }
}
