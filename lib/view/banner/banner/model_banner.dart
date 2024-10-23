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

class BannerData {
  int id;
  String title;
  String? link;
  String? linkLabel;
  int columns;
  int serialNumber;
  String featureImage;

  BannerData({
    required this.id,
    required this.title,
    this.link,
    this.linkLabel,
    required this.columns,
    required this.serialNumber,
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
      'feature_image': featureImage,
    };
  }
}
