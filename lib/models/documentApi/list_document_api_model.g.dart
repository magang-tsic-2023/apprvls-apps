// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_document_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListDocumentApiModel _$ListDocumentApiModelFromJson(
        Map<String, dynamic> json) =>
    ListDocumentApiModel(
      status: json['status'] as String,
      listDocument: (json['listDocument'] as List<dynamic>)
          .map((e) => DocumentApi.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListDocumentApiModelToJson(
        ListDocumentApiModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'listDocument': instance.listDocument,
    };
