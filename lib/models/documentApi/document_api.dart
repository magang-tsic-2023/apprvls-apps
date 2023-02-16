import 'package:json_annotation/json_annotation.dart';

part 'document_api.g.dart';

/// {@template document_api}
/// DocumentApi description
/// {@endtemplate}
@JsonSerializable()
class DocumentApi {
  /// {@macro document_api}
  DocumentApi({
    this.id,
    this.name,
    this.url,
    this.createdByName,
    this.createdAt,
    this.updatedAt,
    this.admin1Name,
    this.admin1Approve,
    this.admin2Name,
    this.admin2Approve,
    this.admin3Name,
    this.admin3Approve,
  });

  /// Creates a DocumentApi from Json map
  factory DocumentApi.fromJson(Map<String, dynamic> data) =>
      _$DocumentApiFromJson(data);

  /// A description for id
  int? id;

  /// A description for name
  String? name;

  /// A description for url
  String? url;

  /// A description for createdByName
  String? createdByName;

  /// A description for createdAt
  String? createdAt;

  /// A description for updatedAt
  String? updatedAt;

  /// A description for admin1Name
  String? admin1Name;

  /// A description for admin1Approve
  int? admin1Approve;

  /// A description for admin2Name
  String? admin2Name;

  /// A description for admin2Approve
  int? admin2Approve;

  /// A description for admin3Name
  String? admin3Name;

  /// A description for admin3Approve
  int? admin3Approve;

  /// Creates a copy of the current DocumentApi with property changes
  DocumentApi copyWith({
    int? id,
    String? name,
    String? url,
    String? createdByName,
    String? createdAt,
    String? updatedAt,
    String? admin1Name,
    int? admin1Approve,
    String? admin2Name,
    int? admin2Approve,
    String? admin3Name,
    int? admin3Approve,
  }) {
    return DocumentApi(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      createdByName: createdByName ?? this.createdByName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      admin1Name: admin1Name ?? this.admin1Name,
      admin1Approve: admin1Approve ?? this.admin1Approve,
      admin2Name: admin2Name ?? this.admin2Name,
      admin2Approve: admin2Approve ?? this.admin2Approve,
      admin3Name: admin3Name ?? this.admin3Name,
      admin3Approve: admin3Approve ?? this.admin3Approve,
    );
  }

  /// Creates a Json map from a DocumentApi
  Map<String, dynamic> toJson() => _$DocumentApiToJson(this);
}
