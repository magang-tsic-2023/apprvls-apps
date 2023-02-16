// To parse this JSON data, do
//
//     final documentAllModelTsic = documentAllModelTsicFromJson(jsonString);

import 'dart:convert';

DocumentAllModelTsic documentAllModelTsicFromJson(String str) =>
    DocumentAllModelTsic.fromJson(json.decode(str));

String documentAllModelTsicToJson(DocumentAllModelTsic data) =>
    json.encode(data.toJson());

class DocumentAllModelTsic {
  DocumentAllModelTsic({
    this.total,
    this.limit,
    this.skip,
    this.data,
  });

  int? total;
  int? limit;
  int? skip;
  List<SingleDocumentModelTsic>? data;

  DocumentAllModelTsic copyWith({
    int? total,
    int? limit,
    int? skip,
    List<SingleDocumentModelTsic>? data,
  }) =>
      DocumentAllModelTsic(
        total: total ?? this.total,
        limit: limit ?? this.limit,
        skip: skip ?? this.skip,
        data: data ?? this.data,
      );

  factory DocumentAllModelTsic.fromJson(Map<String, dynamic> json) =>
      DocumentAllModelTsic(
        total: json["total"],
        limit: json["limit"],
        skip: json["skip"],
        data: json["data"] == null
            ? []
            : List<SingleDocumentModelTsic>.from(
                json["data"]!.map((x) => SingleDocumentModelTsic.fromJson(x))),
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

class SingleDocumentModelTsic {
  SingleDocumentModelTsic({
    this.id,
    this.no,
    this.date,
    this.name,
    this.url,
    this.type,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.approvalsList,
  });

  String? id;
  int? no;
  DateTime? date;
  String? name;
  String? url;
  int? type;
  int? status;
  String? createdBy;
  String? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ApprovalsList>? approvalsList;

  SingleDocumentModelTsic copyWith({
    String? id,
    int? no,
    DateTime? date,
    String? name,
    String? url,
    int? type,
    int? status,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<ApprovalsList>? approvalsList,
  }) =>
      SingleDocumentModelTsic(
        id: id ?? this.id,
        no: no ?? this.no,
        date: date ?? this.date,
        name: name ?? this.name,
        url: url ?? this.url,
        type: type ?? this.type,
        status: status ?? this.status,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        approvalsList: approvalsList ?? this.approvalsList,
      );

  factory SingleDocumentModelTsic.fromJson(Map<String, dynamic> json) =>
      SingleDocumentModelTsic(
        id: json["id"],
        no: json["no"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        name: json["name"],
        url: json["url"],
        type: json["type"],
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        approvalsList: json["approvalsList"] == null
            ? []
            : List<ApprovalsList>.from(
                json["approvalsList"]!.map((x) => ApprovalsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no": no,
        "date": date?.toIso8601String(),
        "name": name,
        "url": url,
        "type": type,
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "approvalsList": approvalsList == null
            ? []
            : List<dynamic>.from(approvalsList!.map((x) => x.toJson())),
      };
}

class ApprovalsList {
  ApprovalsList({
    this.id,
    this.status,
    this.level,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  int? status;
  int? level;
  String? note;
  DateTime? createdAt;
  DateTime? updatedAt;

  ApprovalsList copyWith({
    String? id,
    int? status,
    int? level,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ApprovalsList(
        id: id ?? this.id,
        status: status ?? this.status,
        level: level ?? this.level,
        note: note ?? this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ApprovalsList.fromJson(Map<String, dynamic> json) => ApprovalsList(
        id: json["id"],
        status: json["status"],
        level: json["level"],
        note: json["note"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "level": level,
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
