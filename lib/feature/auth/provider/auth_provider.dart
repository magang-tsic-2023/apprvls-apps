import 'package:flutter/material.dart';
import 'package:laporan_check_apps/models/user_model.dart';
import 'package:laporan_check_apps/services/api_auth_tsic_services.dart';
import 'package:laporan_check_apps/services/mongo_db_user_services.dart';
import 'package:laporan_check_apps/utils/constants.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongDb;

import '../../../models/api_tsic/auth/auth_model_tsic.dart';
import '../../../utils/locator.dart';

class AuthNotifier with ChangeNotifier {
  bool loading = false;
  _startLoading() {
    loading = true;
    notifyListeners();
  }

  _stopLoading() {
    loading = false;
    notifyListeners();
  }

  Future<String> insertUser({
    String? name,
    String? username,
    required String password,
  }) async {
    _startLoading();
    var _id = mongDb.ObjectId();
    final data = UserModel(
      id: _id,
      name: name,
      password: password,
      role: Constants.roleUser,
      username: username,
    );
    var hasil = await locator<MongoDbUserServices>().insert(data);
    notifyListeners();
    _stopLoading();
    return hasil;
  }

  List<UserModel>? listUser = [];
  Future getListUser() async {
    listUser = await locator<MongoDbUserServices>().getData();
    notifyListeners();
    return listUser;
  }

  Future<bool> login({
    required String? userName,
    required String? password,
  }) async {
    _startLoading();
    var hasil = await locator<MongoDbUserServices>()
        .login(userName: userName, password: password);
    notifyListeners();
    _stopLoading();
    return hasil;
  }

  UserModelTsic? _userModelTsic;
  UserModelTsic? get userModelTsic => _userModelTsic;
  Future<UserModelTsic?> loginApi({
    required String? userName,
    required String? password,
  }) async {
    _startLoading();
    _userModelTsic = await locator<ApiAuthTsicServices>()
        .login(username: userName, password: password);
    notifyListeners();
    _stopLoading();
    return _userModelTsic;
  }
}
