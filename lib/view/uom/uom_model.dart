class UomModel {
  final int id;
  final String name;

  UomModel({required this.id, required this.name});

  factory UomModel.fromJson(Map<String, dynamic> json) {
    return UomModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class UomResponse {
  final bool status;
  final List<UomModel> uomList;

  UomResponse({required this.status, required this.uomList});

  factory UomResponse.fromJson(Map<String, dynamic> json) {
    return UomResponse(
      status: json['status'],
      uomList: List<UomModel>.from(
          json['data']['uom'].map((uom) => UomModel.fromJson(uom))),
    );
  }
}
