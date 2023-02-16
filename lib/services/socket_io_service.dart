import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../utils/constants.dart';
import '../utils/locator.dart';
import '../utils/logger.dart';
import 'notification_services.dart';

class SocketIoServices {
  IO.Socket? _socket;

  ///init socket
  initSocket() {
    _socket = IO.io(Constants.serverIo, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    _socket?.connect();
    _socket?.onConnect((_) {
      logger.d('Connection established from android');
      _socket?.emit('connection', 'test android');
    });
    _socket?.on('connection', (data) => logger.d('data $data'));
    _socket?.on('fromServer', (_) async {
      // await locator<NotificationServices>().showNotification(title: _);
      logger.d('message $_');

      logger.d('from server= $_');
    });
    //
    _socket?.on('dokumenBaru', (_) async {
      await locator<NotificationServices>().showNotification(
        title: 'Dokumen baru',
        body: 'Dokumen baru butuh verifikasi',
      );
    });
    _socket?.on('admin1Approve', (_) async {
      await locator<NotificationServices>().showNotification(
        title: 'Admin1 approve dokumen baru',
        body: 'Butuh approve dari admin2',
      );
    });
    _socket?.on('hasilApprove', (data) async {
      await locator<NotificationServices>().showNotification(
        title: 'Status baru dokumen anda',
        body: '$data',
      );
    });
    _socket?.onDisconnect((_) => print('Connection Disconnection'));
    _socket?.onConnectError((err) => print(err));
    _socket?.onError((err) => print(err));
  }

  /// untuk dispose
  disposeSocket() {
    _socket?.disconnect();
    _socket?.dispose();
  }

  sendMessage({String? event, String? data}) {
    Map messageMap = {
      'message': "message",
      'senderId': "userId",
      'receiverId': "receiverId",
      'time': DateTime.now().millisecondsSinceEpoch,
    };
    // _socket?.emit('sendNewMessage', messageMap);
    _socket?.emit('msg', 'halo');
    // _socket?.emit('sendNewMessage', messageMap);
    _socket?.emit('$event', '$data');
  }
}
