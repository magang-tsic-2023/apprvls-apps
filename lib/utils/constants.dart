class Constants {
  static const String mongoDBUrl =
      'mongodb+srv://m4nSal:m4nsal__g3Ni0@prototipe2-app-db.dddxvon.mongodb.net/laporanDb?retryWrites=true&w=majority';
  static const String mongoCollectionUser = 'users';
  static const String mongoCollectionDocument = 'document';

  // hive string
  static const String hiveUserDb = 'userDb';
  static const String hiveIsLogin = 'isLogin';
  static const String hiveUsername = 'username';
  static const String hiveName = 'name';
  static const String hiveRole = 'role';
  static const String hiveUserId = 'userId';

  // role
  static const String roleUser = 'user';
  static const String roleAdmin1 = 'admin1';
  static const String roleAdmin2 = 'admin2';
  static const String roleAdmin3 = 'admin3';

  // status dokumen
  static const String pending = 'pending';
  static const String approve = 'approve';
  static const String reject = 'reject';

  // server socket
  static const String serverIo = 'https://ritzy-silly-paddleboat.glitch.me';
  static const String msgDokbaru = 'dokumenBaruAndroid';
  static const String msgAdmin1ApproveAndroid = 'admin1ApproveAndroid';
  static const String msgHasilApproveAndroid = 'hasilApproveAndroid';
}
