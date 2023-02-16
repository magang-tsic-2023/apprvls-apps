// To parse this JSON data, do
//
//     final userModelTsic = userModelTsicFromJson(jsonString);

import 'dart:convert';

UserModelTsic userModelTsicFromJson(String str) =>
    UserModelTsic.fromJson(json.decode(str));

String userModelTsicToJson(UserModelTsic data) => json.encode(data.toJson());

class UserModelTsic {
  UserModelTsic({
    this.accessToken,
    this.authentication,
    this.user,
  });

  String? accessToken;
  Authentication? authentication;
  User? user;

  UserModelTsic copyWith({
    String? accessToken,
    Authentication? authentication,
    User? user,
  }) =>
      UserModelTsic(
        accessToken: accessToken ?? this.accessToken,
        authentication: authentication ?? this.authentication,
        user: user ?? this.user,
      );

  factory UserModelTsic.fromJson(Map<String, dynamic> json) => UserModelTsic(
        accessToken: json["accessToken"],
        authentication: json["authentication"] == null
            ? null
            : Authentication.fromJson(json["authentication"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "authentication": authentication?.toJson(),
        "user": user?.toJson(),
      };
}

class Authentication {
  Authentication({
    this.strategy,
    this.payload,
  });

  String? strategy;
  Payload? payload;

  Authentication copyWith({
    String? strategy,
    Payload? payload,
  }) =>
      Authentication(
        strategy: strategy ?? this.strategy,
        payload: payload ?? this.payload,
      );

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
        strategy: json["strategy"],
        payload:
            json["payload"] == null ? null : Payload.fromJson(json["payload"]),
      );

  Map<String, dynamic> toJson() => {
        "strategy": strategy,
        "payload": payload?.toJson(),
      };
}

class Payload {
  Payload({
    this.iat,
    this.exp,
    this.aud,
    this.sub,
    this.jti,
  });

  int? iat;
  int? exp;
  String? aud;
  String? sub;
  String? jti;

  Payload copyWith({
    int? iat,
    int? exp,
    String? aud,
    String? sub,
    String? jti,
  }) =>
      Payload(
        iat: iat ?? this.iat,
        exp: exp ?? this.exp,
        aud: aud ?? this.aud,
        sub: sub ?? this.sub,
        jti: jti ?? this.jti,
      );

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        iat: json["iat"],
        exp: json["exp"],
        aud: json["aud"],
        sub: json["sub"],
        jti: json["jti"],
      );

  Map<String, dynamic> toJson() => {
        "iat": iat,
        "exp": exp,
        "aud": aud,
        "sub": sub,
        "jti": jti,
      };
}

class User {
  User({
    this.id,
    this.role,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.profile,
  });

  String? id;
  int? role;
  String? email;
  DateTime? createdAt;
  DateTime? updatedAt;
  Profile? profile;

  User copyWith({
    String? id,
    int? role,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
    Profile? profile,
  }) =>
      User(
        id: id ?? this.id,
        role: role ?? this.role,
        email: email ?? this.email,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        profile: profile ?? this.profile,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        role: json["role"],
        email: json["email"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
        "email": email,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "profile": profile?.toJson(),
      };
}

class Profile {
  Profile({
    this.id,
    this.fullName,
    this.department,
    this.position,
    this.updatedAt,
  });

  String? id;
  String? fullName;
  String? department;
  String? position;
  DateTime? updatedAt;

  Profile copyWith({
    String? id,
    String? fullName,
    String? department,
    String? position,
    DateTime? updatedAt,
  }) =>
      Profile(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        department: department ?? this.department,
        position: position ?? this.position,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        fullName: json["full_name"],
        department: json["department"],
        position: json["position"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "department": department,
        "position": position,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
