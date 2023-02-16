import 'package:json_annotation/json_annotation.dart';
import 'package:laporan_check_apps/models/documentApi/document_api.dart';

part 'list_document_api_model.g.dart';

/// {@template document_api}
/// ListDocumentApiModel description
/// {@endtemplate}
@JsonSerializable()
class ListDocumentApiModel {
  /// {@macro document_api}
  const ListDocumentApiModel({
    required this.status,
    required this.listDocument,
  });

  /// Creates a ListDocumentApiModel from Json map
  factory ListDocumentApiModel.fromJson(Map<String, dynamic> data) =>
      _$ListDocumentApiModelFromJson(data);

  /// A description for status
  final String status;

  /// A description for listDocument
  final List<DocumentApi> listDocument;

  /// Creates a Json map from a ListDocumentApiModel
  Map<String, dynamic> toJson() => _$ListDocumentApiModelToJson(this);
}
