class CreateAttribute {
    final String? message;
    final Data? data;

    CreateAttribute({
        this.message,
        this.data,
    });

    factory CreateAttribute.fromJson(Map<String, dynamic> json) => CreateAttribute(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    final String? name;
    final int? order;
    final int? shopId;
    final DateTime? updatedAt;
    final DateTime? createdAt;
    final int? id;

    Data({
        this.name,
        this.order,
        this.shopId,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        order: json["order"],
        shopId: json["shop_id"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "order": order,
        "shop_id": shopId,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
