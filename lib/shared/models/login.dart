class Login {
  final String? token;
  final UserData? user;

  Login({
    this.token,
    this.user,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        token: json["token"],
        user: json["user"] == null ? null : UserData.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user?.toJson(),
      };
}

class UserData {
  final int? id;
  final int? shopId;
  final int? roleId;
  final String? name;
  final dynamic niceName;
  final String? email;
  final dynamic dob;
  final dynamic sex;
  final dynamic description;
  final dynamic lastVisitedAt;
  final dynamic lastVisitedFrom;
  final bool? active;
  final dynamic apiToken;
  final dynamic fcmToken;
  final dynamic emailVerifiedAt;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserData({
    this.id,
    this.shopId,
    this.roleId,
    this.name,
    this.niceName,
    this.email,
    this.dob,
    this.sex,
    this.description,
    this.lastVisitedAt,
    this.lastVisitedFrom,
    this.active,
    this.apiToken,
    this.fcmToken,
    this.emailVerifiedAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        shopId: json["shop_id"],
        roleId: json["role_id"],
        name: json["name"],
        niceName: json["nice_name"],
        email: json["email"],
        dob: json["dob"],
        sex: json["sex"],
        description: json["description"],
        lastVisitedAt: json["last_visited_at"],
        lastVisitedFrom: json["last_visited_from"],
        active: json["active"],
        apiToken: json["api_token"],
        fcmToken: json["fcm_token"],
        emailVerifiedAt: json["email_verified_at"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "role_id": roleId,
        "name": name,
        "nice_name": niceName,
        "email": email,
        "dob": dob,
        "sex": sex,
        "description": description,
        "last_visited_at": lastVisitedAt,
        "last_visited_from": lastVisitedFrom,
        "active": active,
        "api_token": apiToken,
        "fcm_token": fcmToken,
        "email_verified_at": emailVerifiedAt,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
