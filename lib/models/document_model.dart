// To parse this JSON data, do
//
//     final mongoDbModel = mongoDbModelFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

DocumentModel mongoDbModelFromJson(String str) =>
    DocumentModel.fromJson(json.decode(str));

String mongoDbModelToJson(DocumentModel data) => json.encode(data.toJson());

class DocumentModel {
  DocumentModel({
    required this.id,
    required this.name,
    this.createdById,
    this.createdByName,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.approveAdmin1,
    this.approveAdmin1Id,
    this.approveAdmin1Name,
    this.approveAdmin2,
    this.approveAdmin2Id,
    this.approveAdmin2Name,
    this.dataFile,
    this.tipeData,
  });

  ObjectId? id;
  String? name;
  ObjectId? createdById;
  String? createdByName;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? approveAdmin1;
  ObjectId? approveAdmin1Id;
  String? approveAdmin1Name;
  String? approveAdmin2Name;
  ObjectId? approveAdmin2Id;
  String? approveAdmin2;
  String? dataFile;
  String? tipeData;

  factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
        id: json["_id"],
        name: json["name"],
        createdById: json["createdById"],
        createdByName: json["createdByName"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        deletedAt: json["deletedAt"],
        approveAdmin1Id: json["approveAdmin1Id"],
        approveAdmin1Name: json["approveAdmin1Name"],
        approveAdmin1: json["approveAdmin1"],
        approveAdmin2Id: json["approveAdmin2Id"],
        approveAdmin2Name: json["approveAdmin2Name"],
        approveAdmin2: json["approveAdmin2"],
        dataFile: json["dataFile"],
        tipeData: json["tipeData"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "createdById": createdById,
        "createdByName": createdByName,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "deletedAt": deletedAt,
        "approveAdmin1": approveAdmin1,
        "approveAdmin1Id": approveAdmin1Id,
        "approveAdmin1Name": approveAdmin1Name,
        "approveAdmin2": approveAdmin2,
        "approveAdmin2Id": approveAdmin2Id,
        "approveAdmin2Name": approveAdmin2Name,
        "dataFile": dataFile,
        "tipeData": tipeData,
      };

  DocumentModel copyWith({
    ObjectId? id,
    String? name,
    ObjectId? createdById,
    String? createdByName,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? approveAdmin1,
    ObjectId? approveAdmin1Id,
    String? approveAdmin1Name,
    String? approveAdmin2Name,
    ObjectId? approveAdmin2Id,
    String? approveAdmin2,
    String? dataFile,
    String? tipeData,
  }) {
    return DocumentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      approveAdmin1: approveAdmin1 ?? this.approveAdmin1,
      approveAdmin1Id: approveAdmin1Id ?? this.approveAdmin1Id,
      approveAdmin1Name: approveAdmin1Name ?? this.approveAdmin1Name,
      approveAdmin2: approveAdmin2 ?? this.approveAdmin2,
      approveAdmin2Id: approveAdmin2Id ?? this.approveAdmin2Id,
      approveAdmin2Name: approveAdmin2Name ?? this.approveAdmin2Name,
      createdAt: createdAt ?? this.createdAt,
      createdById: createdById ?? this.createdById,
      createdByName: createdByName ?? this.createdByName,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      dataFile: dataFile ?? this.dataFile,
      tipeData: tipeData ?? this.tipeData,
    );
  }
}
