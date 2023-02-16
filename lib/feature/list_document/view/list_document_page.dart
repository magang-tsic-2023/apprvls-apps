import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:laporan_check_apps/feature/auth/auth.dart';
import 'package:laporan_check_apps/feature/list_document/provider/provider.dart';
import 'package:laporan_check_apps/feature/list_document/widgets/list_document_body.dart';
import 'package:laporan_check_apps/utils/constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:laporan_check_apps/utils/locator.dart';
import '../../../main.dart';
import '../../../services/notification_services.dart';
import '../../../services/socket_io_service.dart';
import '../../notification/notification.dart';
import '../widgets/button_tambah_file.dart';

/// {@template list_document_page}
/// A description for ListDocumentPage
/// {@endtemplate}
class ListDocumentPage extends StatefulWidget {
  /// {@macro list_document_page}
  const ListDocumentPage({Key? key}) : super(key: key);

  /// The static route for ListDocumentPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const ListDocumentPage());
  }

  @override
  State<ListDocumentPage> createState() => _ListDocumentPageState();
}

class _ListDocumentPageState extends State<ListDocumentPage> {
  bool _notificationsEnabled = false;
  @override
  void initState() {
    _isAndroidPermissionGranted();
    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    super.initState();
    locator<SocketIoServices>().initSocket();
  }

  @override
  void dispose() {
    didReceiveLocalNotificationStream.close();
    selectNotificationStream.close();
    // locator<SocketIoServices>().disposeSocket();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box(Constants.hiveUserDb);

    return Provider(
      create: (context) =>
          ChangeNotifierProvider(create: (_) => ListDocumentNotifier()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('List document -  ${box.get(Constants.hiveName)}'),
          actions: [
            // IconButton(
            //     onPressed: () async {
            //       // await locator<NotificationServices>().showNotification();
            //       locator<SocketIoServices>()
            //           .sendMessage(event: Constants.msgDokbaru);
            //       // locator<SocketIoServices>()
            //       //     .sendMessage(event: 'admin1ApproveAndroid');
            //       // locator<SocketIoServices>().sendMessage(
            //       //     event: 'hasilApproveAndroid', data: Constants.reject);
            //     },
            //     icon: Icon(Icons.notifications)),
            IconButton(
              onPressed: () {
                logout(context);
              },
              icon: Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: ListDocumentView(),
        floatingActionButton:
            (box.get(Constants.hiveRole) == Constants.roleUser)
                ? ButtonTambahFile()
                : null,
      ),
    );
  }

  void logout(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      title: 'Logout',
      desc: 'Yakin mau logout?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.of(context).pushReplacement(AuthPage.route());
        var box = Hive.box(Constants.hiveUserDb);
        box.clear();
      },
    )..show();
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      setState(() {
        _notificationsEnabled = granted;
      });
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
      setState(() {
        _notificationsEnabled = granted ?? false;
      });
    }
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                // await Navigator.of(context).push(
                //   MaterialPageRoute<void>(
                //     builder: (BuildContext context) =>
                //         SecondPage(receivedNotification.payload),
                //   ),
                // );
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      // await Navigator.of(context).push(MaterialPageRoute<void>(
      //   builder: (BuildContext context) => SecondPage(payload),
      // ));
    });
  }
}

/// {@template list_document_view}
/// Displays the Body of ListDocumentView
/// {@endtemplate}
class ListDocumentView extends StatelessWidget {
  /// {@macro list_document_view}
  const ListDocumentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListDocumentBody();
  }
}
