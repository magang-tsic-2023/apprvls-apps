import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laporan_check_apps/models/document_model.dart';
import 'package:laporan_check_apps/utils/constants.dart';
import 'package:laporan_check_apps/utils/logger.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongDb;
import 'package:mongo_dart/mongo_dart.dart';

import '../../../services/mongo_db_document_services.dart';
import '../../../services/socket_io_service.dart';
import '../../../utils/locator.dart';

class ListDocumentNotifier with ChangeNotifier {
  bool loading = false;
  _startLoading() {
    loading = true;
    notifyListeners();
  }

  _stopLoading() {
    loading = false;
    notifyListeners();
  }

  List<DocumentModel> listDocument = [];
  Future getDocument() async {
    _startLoading();
    var hasil = await locator<MongoDbDocumentServices>().getData();
    logger.d('hasil = ${hasil.length}');
    listDocument = hasil.map((e) => DocumentModel.fromJson(e)).toList();
    notifyListeners();
    _stopLoading();
    return listDocument;
  }

  Future<String> insertDocument({String? name, File? file}) async {
    var box = Hive.box(Constants.hiveUserDb);
    var userId = box.get(Constants.hiveUserId);
    logger.d('all box user id $userId');
    logger.d('all box ${box.values.cast()}');
    _startLoading();
    final bytes = file?.readAsBytesSync();

    String file64 = base64Encode(bytes!);
    var _id = mongDb.ObjectId();
    final data = DocumentModel(
        id: _id,
        name: name,
        approveAdmin1: '',
        approveAdmin2: '',
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: '',
        deletedAt: '',
        createdById: ObjectId.fromHexString(userId),
        dataFile: file64,
        tipeData: 'pdf');
    var hasil = await locator<MongoDbDocumentServices>().insert(data);
    locator<SocketIoServices>().sendMessage(event: 'dokumenBaruAndroid');

    logger.d(hasil);
    notifyListeners();
    _stopLoading();
    return hasil;
  }

  Future updateDocument(DocumentModel documentModel) async {
    _startLoading();
    var hasil = await locator<MongoDbDocumentServices>().update(documentModel);
    locator<SocketIoServices>().sendMessage();

    notifyListeners();
    _stopLoading();
  }

  Future deleteDocument(DocumentModel documentModel) async {
    _startLoading();
    var hasil = await locator<MongoDbDocumentServices>().delete(documentModel);

    notifyListeners();
    _stopLoading();
  }
}
