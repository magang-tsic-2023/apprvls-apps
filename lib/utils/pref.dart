import 'package:hive_flutter/hive_flutter.dart';
import 'package:laporan_check_apps/utils/constants.dart';

// use prefs to save temporary data, which usually cleared when log out using Prefs().clear
class Prefs {
  final box = Hive.box(Constants.hiveUserDb);

  static const String urlKey = 'url';
  static const String loginKey = 'login';
  static const String tokenKey = 'token';
  static const String emailKey = 'email';
  static const String roleKey = 'role';
  static const String fullNameKey = 'fullName';
  static const String idUserKey = 'idUser';

  final List<String> keys = [
    urlKey,
    loginKey,
    tokenKey,
    emailKey,
    roleKey,
    fullNameKey
  ];

  String get allValue {
    String value = 'Prefs getAllValue: ';
    for (String key in keys) {
      value += '$key=${box.get(key)} | ';
    }
    return value;
  }

  String get url => box.get(urlKey) ?? 'Url not assigned';
  set url(String val) => box.put(urlKey, val);

  bool get isLogin => box.get(loginKey) ?? false;
  set isLogin(bool val) => box.put(loginKey, val);

  String? get token => box.get(tokenKey) ?? false;
  set token(String? val) => box.put(tokenKey, val);

  String? get email => box.get(emailKey);
  set email(String? val) => box.put(emailKey, val);

  String? get fullName => box.get(fullNameKey);
  set fullName(String? val) => box.put(fullNameKey, val);
  String? get idUser => box.get(idUserKey);
  set idUser(String? val) => box.put(idUserKey, val);

  int? get role => box.get(roleKey);
  set role(int? val) => box.put(roleKey, val);

  Future<void> clearPrefs() async => await box.clear();
}
