import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laporan_check_apps/models/api_tsic/document/document_model_all.dart';
import 'package:laporan_check_apps/utils/locator.dart';

import '../../../models/api_tsic/auth/auth_model_tsic.dart';
import '../../../models/documentApi/document_api.dart';
import '../../../models/documentApi/list_document_api_model.dart';
import '../../../services/api_dokument_services.dart';
import '../../../utils/constants.dart';
import '../../../utils/logger.dart';

class DokumentApiNotifier with ChangeNotifier {
  bool loading = false;
  _startLoading() async {
    logger.d('mulai _start loading');

    loading = true;
    // Future.delayed(Duration(seconds: 10)).then((value) {
    //   loading = false;
    // });
    notifyListeners();
  }

  _stopLoading() {
    logger.d('mulai _stop loading');

    loading = false;
    notifyListeners();
  }

  User? _user;
  User? get user => _user;

  Future<User?> getSingleUser(String userId) async {
    try {
      _user = await locator<ApiDokumentServices>().getSingleUser(userId);

      return _user;
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  DocumentAllModelTsic? _documentAllModelTsic;
  DocumentAllModelTsic? get documentAllModelTsic => _documentAllModelTsic;

  List<SingleDocumentModelTsic?>? _listDocumentTsic;
  List<SingleDocumentModelTsic?>? get listDocumentTsic {
    _listDocumentTsic = _documentAllModelTsic?.data;
    _listDocumentTsic?.sort((a, b) => a?.no?.compareTo(b?.no ?? 0) ?? 0);
    return _listDocumentTsic;
  }

  SingleDocumentModelTsic? _singleDocumentModelTsic;
  SingleDocumentModelTsic? get singleDocumentModelTsic =>
      _singleDocumentModelTsic;
  getDocument() async {
    _startLoading();
    _documentAllModelTsic = await locator<ApiDokumentServices>().getDocument();
    _listDocumentTsic = _documentAllModelTsic?.data;
    _listDocumentTsic?.sort((a, b) => a?.no?.compareTo(b?.no ?? 0) ?? 0);
    notifyListeners();
    _stopLoading();

    return _documentAllModelTsic;
  }

  Future addDocument({String? name, String? url}) async {
    _startLoading();

    _singleDocumentModelTsic =
        await locator<ApiDokumentServices>().addDocument(name: name, url: url);
    notifyListeners();
    _stopLoading();

    return _singleDocumentModelTsic;
  }

  updateDocument({
    String? name,
    String? url,
    required String? idDocument,
  }) async {
    _startLoading();

    _singleDocumentModelTsic = await locator<ApiDokumentServices>()
        .updateDocument(name: name, url: url, idDocument: idDocument);
    _listDocumentTsic = _documentAllModelTsic?.data;
    _listDocumentTsic?.sort((a, b) => a?.no?.compareTo(b?.no ?? 0) ?? 0);
    notifyListeners();
    _stopLoading();

    return _singleDocumentModelTsic;
  }

  deleteDocument({
    required String? idDocument,
  }) async {
    _startLoading();
    _singleDocumentModelTsic = await locator<ApiDokumentServices>()
        .deleteDocument(idDocument: idDocument);
    notifyListeners();
    _stopLoading();

    return _singleDocumentModelTsic;
  }

  Future updateApproval({int? status, required String? idApproval}) async {
    _startLoading();

    var data = await locator<ApiDokumentServices>()
        .updateApproval(status: status, idApproval: idApproval);
    _stopLoading();

    notifyListeners();

    return data;
  }

  /// di bawah ini ga di pakai hanya sample

  // List<DocumentApi>? _listDocument =
  //     locator<ApiDokumentServices>().listDocument;
  List<DocumentApi>? _listDocument = [];

  List<DocumentApi>? get listDocumentSample {
    return _listDocument;
  }

  ListDocumentApiModel? _listDocumentApiModel;
  Future<List<DocumentApi>?> getListDocumentSample() async {
    var box = Hive.box(Constants.hiveUserDb);
    var userLogin = await box.get(Constants.hiveRole);
    logger.d('login role = $userLogin');
    switch (userLogin) {
      case Constants.roleAdmin1:
        notifyListeners();

        return _listDocument;
      case Constants.roleAdmin2:
        _listDocument = _listDocument?.where((val) {
          if (val.admin1Approve != null) {
            return true;
          } else {
            return false;
          }
        }).toList();
        notifyListeners();

        return _listDocument;
      case Constants.roleAdmin3:
        _listDocument = _listDocument?.where((val) {
          if (val.admin1Approve != null && val.admin2Approve != null) {
            return true;
          } else {
            return false;
          }
        }).toList();
        notifyListeners();

        return _listDocument;
      default:
        return _listDocument;
    }
    logger.d('listDocument ${listDocumentSample?.length}');

    // notifyListeners();
    // return _listDocument;
  }

  Future addDocumentApiSample(DocumentApi documentApi) async {
    List<DocumentApi>? _listDocument2 = [];
    _listDocument2
        .add(documentApi.copyWith(id: (listDocumentSample?.length ?? 0) + 1));
    _listDocument?.addAll(_listDocument2);
    logger.d(listDocumentSample?.last.toJson());
    var box = Hive.box(Constants.hiveUserDb);
    notifyListeners();
    return _listDocument;
  }

  Future updateDocumentApiSample(DocumentApi documentApi) async {
    _listDocument?.firstWhere(
      (element) {
        if (element.id == documentApi.id) {
          element.id = documentApi.id;
          element.name = documentApi.name;
          element.url = documentApi.url;
          element.createdAt = documentApi.createdAt;
          element.updatedAt = documentApi.updatedAt;
          element.createdByName = documentApi.createdByName;
          element.admin1Name = documentApi.admin1Name;
          element.admin1Approve = documentApi.admin1Approve;
          element.admin2Name = documentApi.admin2Name;
          element.admin2Approve = documentApi.admin2Approve;
          element.admin3Name = documentApi.admin3Name;
          element.admin3Approve = documentApi.admin3Approve;

          logger.d(element.toJson().toString());
          return true;
        }

        return false;
      },
    );

    notifyListeners();
    return _listDocument;
  }

  Future deleteDocumentApiSample(DocumentApi? documentApi) async {
    _listDocument?.removeWhere(
      (element) {
        if (element.id == documentApi?.id) {
          return true;
        }

        return false;
      },
    );

    notifyListeners();
    return _listDocument;
  }
}
