import 'dart:developer';

import 'package:hive_flutter/adapters.dart';
import 'package:laporan_check_apps/services/mongo_db_services.dart';
import 'package:laporan_check_apps/utils/constants.dart';
import 'package:laporan_check_apps/utils/logger.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../models/user_model.dart';
import '../utils/locator.dart';

class MongoDbUserServices {
  Future<List<UserModel>> getData() async {
    Db db = await Db.create(Constants.mongoDBUrl);
    await db.open();
    final arrData = await db
        .collection(Constants.mongoCollectionUser)
        .find()
        .toList() as List<UserModel>;
    return arrData;
  }

  Future<bool> login({
    required String? userName,
    required String? password,
  }) async {
    Db db = await Db.create(Constants.mongoDBUrl);
    await db.open();
    var box = Hive.box(Constants.hiveUserDb);

    final hasilGetUser = await db
        .collection(Constants.mongoCollectionUser)
        .findOne(where.eq('username', userName));
    if (hasilGetUser?['username'] == userName) {
      if (hasilGetUser?['password'] == password) {
        logger.d('sukses masuk');

        ObjectId userId = hasilGetUser?['_id'];
        box.put(Constants.hiveIsLogin, true);
        box.put(Constants.hiveName, hasilGetUser?['name']);
        // ObjectId pada userId diubah ke string karena lokal database (hive) tidak bisa
        // menyimpan ObjectId
        box.put(Constants.hiveUserId, userId.toHexString());
        box.put(Constants.hiveRole, hasilGetUser?['role']);

        return true;
      } else {
        logger.d('password salah');
        return false;
      }
    } else {
      logger.d('user tidak ada');
      return false;
    }
  }

  Future<bool> loginApi({
    required String? userName,
    required String? password,
  }) async {
    var box = Hive.box(Constants.hiveUserDb);
    box.put(Constants.hiveIsLogin, true);
    switch (password) {
      case 'passuser':
        logger.d('user sukses masuk');
        box.put(Constants.hiveName, '$userName - user');
        box.put(Constants.hiveRole, Constants.roleUser);

        return true;
      case 'passadmin1':
        logger.d('admin1 sukses masuk');
        box.put(Constants.hiveName, '$userName - admin1');
        box.put(Constants.hiveRole, Constants.roleAdmin1);

        return true;
      case 'passadmin2':
        logger.d('admin2 sukses masuk');
        box.put(Constants.hiveName, '$userName - admin2');
        box.put(Constants.hiveRole, Constants.roleAdmin2);

        return true;
      case 'passadmin3':
        logger.d('admin3 sukses masuk');
        box.put(Constants.hiveName, '$userName - admin3');
        box.put(Constants.hiveRole, Constants.roleAdmin3);

        return true;
      default:
        return false;
    }
  }

  Future<void> update(UserModel data) async {
    Db db = await Db.create(Constants.mongoDBUrl);
    await db.open();
    var result = await db
        .collection(Constants.mongoCollectionUser)
        .findOne({"_id": data.id});
    result?['name'] = data.name;
    result?['username'] = data.username;
    result?['password'] = data.password;
    var respone = await db
        .collection(Constants.mongoCollectionUser)
        .update({"_id": data.id}, result);
    inspect(respone);
  }

  delete(UserModel user) async {
    Db db = await Db.create(Constants.mongoDBUrl);
    await db.open();
    await db
        .collection(Constants.mongoCollectionUser)
        .remove(where.id(user.id));
  }

  Future<String> insert(UserModel data) async {
    logger.d(data.toJson().toString());
    try {
      Db db = await Db.create(Constants.mongoDBUrl);
      await db.open();
      WriteResult? result = await db
          .collection(Constants.mongoCollectionUser)
          .insertOne(data.toJson());
      if (result.isSuccess) {
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
}
