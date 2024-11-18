import 'package:isotopeit_b2b/view/banner/add_banner/banner_add_model.dart';

class ApiResponse {
  String status;
  List<BannerData> data;

  ApiResponse({required this.status, required this.data});

  // Factory constructor to create an instance from a JSON map
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'],
      data: List<BannerData>.from(
          json['data'].map((item) => BannerData.fromJson(item))),
    );
  }

  // Convert the instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': List<dynamic>.from(data.map((item) => item.toJson())),
    };
  }
}

// class BannerData {
//   int id;
//   String ? title;
//   String? link;
//   String? linkLabel;
//   int ? columns;
//   int ? serialNumber;
//   String featureImage;
//    String? description; 

//   BannerData({
//     required this.id,
//     required this.title,
//     this.link,
//     this.linkLabel,
//     this.columns,
//     this.serialNumber,
//      this.description,
//     required this.featureImage,
//   });

//   // Factory constructor to create an instance from a JSON map
//   factory BannerData.fromJson(Map<String, dynamic> json) {
//     return BannerData(
//       id: json['id'],
//       title: json['title'],
//       link: json['link'],
//       linkLabel: json['link_label'],
//       columns: json['columns'],
//       serialNumber: json['serial_number'],
//       description: json['description'],
//       featureImage: json['feature_image'],
//     );
//   }

//   // Convert the instance to a JSON map
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'link': link,
//       'link_label': linkLabel,
//       'columns': columns,
//       'serial_number': serialNumber,
//        'description': description, 
//       'feature_image': featureImage,
//     };
//   }
// }




class BannerData {
  int id;
  String? title;
  String? link;
  String? linkLabel;
  int? columns;
  int? serialNumber;
  String featureImage;
  String? description;

  BannerData({
    required this.id,
    required this.title,
    this.link,
    this.linkLabel,
    this.columns,
    this.serialNumber,
    this.description,
    required this.featureImage,
  });

  // Factory constructor to create an instance from a JSON map
  factory BannerData.fromJson(Map<String, dynamic> json) {
    return BannerData(
      id: json['id'],
      title: json['title'],
      link: json['link'],
      linkLabel: json['link_label'],
      columns: json['columns'],
      serialNumber: json['serial_number'],
      description: json['description'],
      featureImage: json['feature_image'],
    );
  }

  // Convert the instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'link': link,
      'link_label': linkLabel,
      'columns': columns,
      'serial_number': serialNumber,
      'description': description,
      'feature_image': featureImage,
    };
  }

  // Method to convert BannerData to BannerModel
  BannerModel toBannerModel() {
    return BannerModel(
      id: this.id,
      title: this.title,
      link: this.link,
      linkLabel: this.linkLabel,
      bgColor: '', // You can set a default value or pass it from somewhere else
      columns: this.columns?.toString(), // Convert int to String if needed
      order: '', // Add logic to determine order if necessary
      effect: false, // Set a default value
      shopId: 0, // You can adjust this logic as needed
      featureImage: this.featureImage,
      createdAt: DateTime.now(), // Adjust as needed
      updatedAt: DateTime.now(), // Adjust as needed
      description: this.description,
    );
  }
}

