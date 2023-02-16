// To parse this JSON data, do
//
//     final userModelTsic = userModelTsicFromJson(jsonString);

import 'dart:convert';

UserModelTsic userModelTsicFromJson(String str) =>
    UserModelTsic.fromJson(json.decode(str));

String userModelTsicToJson(UserModelTsic data) => json.encode(data.toJson());

class UserModelTsic {
  UserModelTsic({
    this.total,
    this.limit,
    this.skip,
    this.data,
  });

  int? total;
  int? limit;
  int? skip;
  List<DataUserModelTsic>? data;

  UserModelTsic copyWith({
    int? total,
    int? limit,
    int? skip,
    List<DataUserModelTsic>? data,
  }) =>
      UserModelTsic(
        total: total ?? this.total,
        limit: limit ?? this.limit,
        skip: skip ?? this.skip,
        data: data ?? this.data,
      );

  factory UserModelTsic.fromJson(Map<String, dynamic> json) => UserModelTsic(
        total: json["total"],
        limit: json["limit"],
        skip: json["skip"],
        data: json["data"] == null
            ? []
            : List<DataUserModelTsic>.from(
                json["data"]!.map((x) => DataUserModelTsic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
        "skip": skip,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataUserModelTsic {
  DataUserModelTsic({
    this.id,
    this.fullName,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.roles,
  });

  String? id;
  String? fullName;
  String? email;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<int>? roles;

  DataUserModelTsic copyWith({
    String? id,
    String? fullName,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<int>? roles,
  }) =>
      DataUserModelTsic(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        roles: roles ?? this.roles,
      );

  factory DataUserModelTsic.fromJson(Map<String, dynamic> json) =>
      DataUserModelTsic(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        roles: json["roles"] == null
            ? []
            : List<int>.from(json["roles"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "email": email,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
      };
}
