// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names

import 'dart:developer';

import 'package:laporan_check_apps/utils/constants.dart';
import 'package:laporan_check_apps/utils/logger.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../models/user_model.dart';

class MongoDatabaseServices {
  Db? db;
  DbCollection? userCollection;
  DbCollection? documentCollection;
  connect() async {
    db = await Db.create(Constants.mongoDBUrl);

    await db?.open();
    inspect(db);
    userCollection = db?.collection(Constants.mongoCollectionUser);
    documentCollection = db?.collection(Constants.mongoCollectionDocument);
  }
}
