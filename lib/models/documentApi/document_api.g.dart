part of 'document_api.dart';

DocumentApi _$DocumentApiFromJson(Map<String, dynamic> json) => DocumentApi(
      id: json['id'] as int?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      createdByName: json['createdByName'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      admin1Name: json['admin1Name'] as String?,
      admin1Approve: json['admin1Approve'] as int?,
      admin2Name: json['admin2Name'] as String?,
      admin2Approve: json['admin2Approve'] as int?,
      admin3Name: json['admin3Name'] as String?,
      admin3Approve: json['admin3Approve'] as int?,
    );

Map<String, dynamic> _$DocumentApiToJson(DocumentApi instance) => <String, dynamic>{ 
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'createdByName': instance.createdByName,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'admin1Name': instance.admin1Name,
      'admin1Approve': instance.admin1Approve,
      'admin2Name': instance.admin2Name,
      'admin2Approve': instance.admin2Approve,
      'admin3Name': instance.admin3Name,
      'admin3Approve': instance.admin3Approve,
    };