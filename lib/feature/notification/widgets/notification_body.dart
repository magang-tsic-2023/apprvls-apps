import 'package:flutter/material.dart';
import 'package:laporan_check_apps/feature/notification/provider/provider.dart';
import 'package:laporan_check_apps/utils/constants.dart';
import 'package:laporan_check_apps/utils/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

/// {@template notification_body}
/// Body of the NotificationPage.
///
/// Add what it does
/// {@endtemplate}
class NotificationBody extends StatefulWidget {
  /// {@macro notification_body}
  const NotificationBody({Key? key}) : super(key: key);

  @override
  State<NotificationBody> createState() => _NotificationBodyState();
}

class _NotificationBodyState extends State<NotificationBody> {
  IO.Socket? socket;
  @override
  void initState() {
    initSocket();
    super.initState();
  }

  initSocket() {
    socket = IO.io(Constants.serverIo, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket?.connect();
    socket?.onConnect((_) {
      logger.d('Connection established from android');
      socket?.emit('connection', 'test android');
    });
    socket?.on('connection', (data) => logger.d('data $data'));
    socket?.on('fromServer', (_) => logger.d('from server= $_'));

    socket?.onDisconnect((_) => print('Connection Disconnection'));
    socket?.onConnectError((err) => print(err));
    socket?.onError((err) => print(err));
  }

  @override
  void dispose() {
    socket?.disconnect();
    socket?.dispose();
    super.dispose();
  }

  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationNotifier>(
      builder: (context, state, child) {
        return Column(
          children: [
            TextField(
              controller: textEditingController,
            ),
            ElevatedButton(
                onPressed: () {
                  sendMessage();
                },
                child: Text('send notif'))
          ],
        );
      },
    );
  }

  sendMessage() {
    String message = textEditingController.text.trim();
    if (message.isEmpty) return;
    Map messageMap = {
      'message': message,
      'senderId': "userId",
      'receiverId': "receiverId",
      'time': DateTime.now().millisecondsSinceEpoch,
    };
    socket?.emit('sendNewMessage', messageMap);
    socket?.emit('msg', 'halo');
  }
}
