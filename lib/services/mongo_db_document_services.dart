import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:laporan_check_apps/models/document_model.dart';
import 'package:laporan_check_apps/services/socket_io_service.dart';
import 'package:laporan_check_apps/utils/constants.dart';
import 'package:laporan_check_apps/utils/logger.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/locator.dart';

class MongoDbDocumentServices {
  Future<List<Map<String, dynamic>>> getData() async {
    var box = Hive.box(Constants.hiveUserDb);
    var idUserLogin = await box.get(Constants.hiveUserId);
    logger.d('getData all box  ${box.values.cast()}');
    Db db = await Db.create(Constants.mongoDBUrl);
    await db.open();
    final List<Map<String, dynamic>> listDokumen;
    var role = box.get(Constants.hiveRole);
    switch (role) {
      case Constants.roleUser:
        listDokumen = await db
            .collection(Constants.mongoCollectionDocument)
            .find(where.eq("createdById", ObjectId.fromHexString(idUserLogin)))
            .toList();
        return listDokumen;

      case Constants.roleAdmin1:
        listDokumen = await db
            .collection(Constants.mongoCollectionDocument)
            .find()
            .toList();
        return listDokumen;

      case Constants.roleAdmin2:
        listDokumen = await db
            .collection(Constants.mongoCollectionDocument)
            .find(where.eq("approveAdmin1", Constants.approve))
            .toList();
        return listDokumen;

      default:
        listDokumen = await db
            .collection(Constants.mongoCollectionDocument)
            .find(where.eq("createdById", ObjectId.fromHexString(idUserLogin)))
            .toList();
        return listDokumen;
    }
  }

  Future<void> update(DocumentModel data) async {
    Db db = await Db.create(Constants.mongoDBUrl);
    await db.open();
    var result = await db
        .collection(Constants.mongoCollectionDocument)
        .findOne({"_id": data.id});
    result?['name'] = data.name;
    result?['approveAdmin1'] = data.approveAdmin1;
    result?['approveAdmin2'] = data.approveAdmin2;
    result?['updatedAt'] = DateTime.now().toIso8601String();
    var respone = await db
        .collection(Constants.mongoCollectionDocument)
        .update({"_id": data.id}, result);

    // jika status approve kirim notif
    if (data.approveAdmin1 == Constants.approve) {
      locator<SocketIoServices>().sendMessage(
          event: Constants.msgAdmin1ApproveAndroid, data: 'admin satu approve');
    }
// jika status reject kirim notif
    if (data.approveAdmin1 == Constants.reject) {
      locator<SocketIoServices>().sendMessage(
          event: Constants.msgHasilApproveAndroid,
          data: 'dokumen ${Constants.reject}');
    }
    // jika status approve admin 2 sudah diisi akan kirim status
    if (data.approveAdmin2 != null || data.approveAdmin2 != '') {
      locator<SocketIoServices>().sendMessage(
          event: Constants.msgHasilApproveAndroid, data: data.approveAdmin2);
    }

    inspect(respone);
  }

  delete(DocumentModel user) async {
    Db db = await Db.create(Constants.mongoDBUrl);
    await db.open();
    await db
        .collection(Constants.mongoCollectionDocument)
        .remove(where.id(user.id ?? ObjectId()));
  }

  Future<String> insert(DocumentModel data) async {
    logger.d(data.toJson().toString());
    try {
      Db db = await Db.create(Constants.mongoDBUrl);
      await db.open();
      WriteResult? result = await db
          .collection(Constants.mongoCollectionDocument)
          .insertOne(data.toJson());
      if (result.isSuccess) {
        locator<SocketIoServices>()
            .sendMessage(event: 'dokumenBaruAndroid', data: 'dokumen baru');

        return "Data Inserted";
      } else {
        logger.e("err = ${result.writeError}");
        return "some Error in appending";
      }
    } catch (e) {
      logger.e(e.toString());
      return e.toString();
    }
  }

  // uploadFile(FilePickerResult? filePickerResult) async {
  //   Db db = await Db.create(Constants.mongoDBUrl);
  //   await db.open();
  //   // GridFS bucket = GridFS(db, Constants.mongoCollectionDocument);
  //   File? file;
  //   if (filePickerResult != null) {
  //     file = File(filePickerResult.files.single.path ?? '--');
  //   } else {
  //     // User canceled the picker
  //   }

  //   final bytes = file?.readAsBytesSync();

  //   String file64 = base64Encode(bytes!);
  //   var _id = ObjectId();
  //   Map<String, dynamic> fileUpload = {
  //     "_id": _id,
  //     "nama_file": filePickerResult?.files.first.path?.split("/").last,
  //     "date_screated": DateTime.now().toIso8601String(),
  //     "data": file64
  //   };
  //   try {
  //     // var res = await bucket.chunks.insert(fileUpload);
  //     WriteResult? result = await db
  //         .collection(Constants.mongoCollectionDocument)
  //         .insertOne(fileUpload);

  //     logger.d('sukses');
  //   } catch (e) {
  //     logger.e(e.toString());
  //     return e.toString();
  //   }
  // }

  // // uploadFilePf(String dataFile)async{
  // //   var ubahUint8ListLagi = base64Decode(dataFile);
  // // }
  Future<File> openFilePdf({
    required String nama,
    required String dataFile,
  }) async {
    var ubahUint8List = base64Decode(dataFile);
    return _simpanFile(nama, ubahUint8List);
  }

  Future<File> _simpanFile(String namaFile, List<int> bytes) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$namaFile');
    await file.writeAsBytes(bytes, flush: true);
    if (kDebugMode) {
      logger.d('$file');
    }
    return file;
  }
}
