import 'package:get_it/get_it.dart';
import 'package:laporan_check_apps/services/mongo_db_user_services.dart';

import '../services/api_dokument_services.dart';
import '../services/api_auth_tsic_services.dart';
import '../services/mongo_db_document_services.dart';
import '../services/mongo_db_services.dart';
import '../services/notification_services.dart';
import '../services/socket_io_service.dart';
import 'loading_helper.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  /// how to use locator<ServiceYangAkanDigunakan>();
  locator.registerLazySingleton(() => MongoDatabaseServices());
  locator.registerLazySingleton(() => MongoDbUserServices());
  locator.registerLazySingleton(() => MongoDbDocumentServices());
  locator.registerLazySingleton(() => LoadingHelper());
  locator.registerLazySingleton(() => NotificationServices());
  locator.registerLazySingleton(() => SocketIoServices());
  locator.registerLazySingleton(() => ApiDokumentServices());
  locator.registerLazySingleton(() => ApiAuthTsicServices());
}
