import 'package:flutter/material.dart';
import 'package:laporan_check_apps/feature/notification/provider/provider.dart';
import 'package:laporan_check_apps/feature/notification/widgets/notification_body.dart';

/// {@template notification_page}
/// A description for NotificationPage
/// {@endtemplate}
class NotificationPage extends StatelessWidget {
  /// {@macro notification_page}
  const NotificationPage({Key? key}) : super(key: key);

  /// The static route for NotificationPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const NotificationPage());
  }
 
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) =>
          ChangeNotifierProvider(create: (_) => NotificationNotifier()),
      child: const Scaffold(
        body: NotificationView(),
      ),
    );
  }   
}

/// {@template notification_view}
/// Displays the Body of NotificationView
/// {@endtemplate}
class NotificationView extends StatelessWidget {
  /// {@macro notification_view}
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NotificationBody();
  }
}
