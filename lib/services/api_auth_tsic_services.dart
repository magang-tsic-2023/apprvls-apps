import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laporan_check_apps/utils/api_helper.dart';
import 'package:laporan_check_apps/utils/end_points.dart';
import 'package:laporan_check_apps/utils/logger.dart';

import '../models/api_tsic/auth/auth_model_tsic.dart';
import '../utils/constants.dart';
import '../utils/pref.dart';

class ApiAuthTsicServices {
  final dio = ApiBaseHelper();

  Future<UserModelTsic?> login({String? username, String? password}) async {
    try {
      var hasil = await dio.post(EndPoints.login, data: {
        "strategy": "local",
        "email": username,
        "password": password,
      });
      UserModelTsic userModelTsic = UserModelTsic.fromJson(hasil);
      Prefs().token = userModelTsic.accessToken;
      Prefs().role = userModelTsic.user?.role;
      Prefs().fullName = userModelTsic.user?.profile?.fullName;
      Prefs().idUser = userModelTsic.user?.id;
      var box = Hive.box(Constants.hiveUserDb);
      box.put(Constants.hiveIsLogin, true);
      box.put(Constants.hiveName, userModelTsic.user?.profile?.fullName);
      box.put(Constants.hiveUserId, userModelTsic.user?.id);
      return userModelTsic;
    } on Exception catch (e) {
      logger.e(e);
    }
  }
}
