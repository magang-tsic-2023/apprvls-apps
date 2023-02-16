import 'package:hive_flutter/hive_flutter.dart';
import 'package:laporan_check_apps/utils/end_points.dart';
import 'package:laporan_check_apps/utils/pref.dart';

import '../models/api_tsic/auth/auth_model_tsic.dart';
import '../models/api_tsic/document/document_model_all.dart';
import '../utils/api_helper.dart';
import '../utils/constants.dart';
import '../utils/logger.dart';

class ApiDokumentServices {
  final dio = ApiBaseHelper.withToken();
  var box = Hive.box(Constants.hiveUserDb);

  Future<User?> getSingleUser(String userId) async {
    try {
      var hasil = await dio.get('${EndPoints.users}/$userId');
      User user = User.fromJson(hasil);

      return user;
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  Future<DocumentAllModelTsic?> getDocument() async {
    try {
      var hasil = await dio.get(EndPoints.documents);
      DocumentAllModelTsic documentAllModelTsic =
          DocumentAllModelTsic.fromJson(hasil);

      return documentAllModelTsic;
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  Future<SingleDocumentModelTsic?> addDocument(
      {String? name, String? url}) async {
    try {
      var hasil = await dio.post(EndPoints.documents,
          data: {"name": name, "url": url, "type": 1});
      SingleDocumentModelTsic singleDocumentModelTsic =
          SingleDocumentModelTsic.fromJson(hasil);

      return singleDocumentModelTsic;
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  Future<SingleDocumentModelTsic?> updateDocument(
      {String? name, String? url, required String? idDocument}) async {
    try {
      var hasil = await dio.patch('${EndPoints.documents}/$idDocument',
          data: {"name": name, "url": url, "type": 1});
      SingleDocumentModelTsic singleDocumentModelTsic =
          SingleDocumentModelTsic.fromJson(hasil);

      return singleDocumentModelTsic;
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  Future<SingleDocumentModelTsic?> deleteDocument(
      {required String? idDocument}) async {
    try {
      var hasil = await dio.delete('${EndPoints.documents}/$idDocument');

      SingleDocumentModelTsic singleDocumentModelTsic =
          SingleDocumentModelTsic.fromJson(hasil);

      return singleDocumentModelTsic;
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  Future<ApprovalsList?> updateApproval(
      {int? status, required String? idApproval}) async {
    try {
      var hasil = await dio.patch('${EndPoints.approvals}/$idApproval',
          data: {"status": status});
      ApprovalsList approvalsList = ApprovalsList.fromJson(hasil);

      return approvalsList;
    } on Exception catch (e) {
      logger.e(e);
    }
  }
}
