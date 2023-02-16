// To parse this JSON data, do
//
//     final mongoDbModel = mongoDbModelFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

UserModel mongoDbModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String mongoDbModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.role,
  });

  ObjectId id;
  String? name;
  String? username;
  String? password;
  String? role;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        password: json["password"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "username": username,
        "password": password,
        "role": role,
      };
}
