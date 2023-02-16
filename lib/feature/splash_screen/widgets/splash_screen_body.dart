import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laporan_check_apps/feature/auth/auth.dart';
import 'package:laporan_check_apps/feature/list_document/list_document.dart';

import '../../../services/socket_io_service.dart';
import '../../../utils/constants.dart';
import '../../../utils/locator.dart';
import '../../dokument_api/dokument_api.dart';

/// {@template splash_screen_body}
/// Body of the SplashScreenPage.
///
/// Add what it does
/// {@endtemplate}
class SplashScreenBody extends StatefulWidget {
  /// {@macro splash_screen_body}
  const SplashScreenBody({Key? key}) : super(key: key);

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) async {
      var box = Hive.box(Constants.hiveUserDb);
      bool? isLogin = box.get(Constants.hiveIsLogin);
      if (isLogin ?? false) {
        // Provider.of<ListDocumentNotifier>(context, listen: false)
        //     .getDocument()
        //     .then((value) {
        //   Navigator.of(context).pushReplacement(ListDocumentPage.route());
        // });
        // Provider.of<DokumentApiNotifier>(context, listen: false)
        //     .getListDocumentSample();
        // Provider.of<ListDocumentNotifier>(context, listen: false).getDocument();
        // Provider.of<DokumentApiNotifier>(context, listen: false).getDocument();
        // Provider.of<DokumentApiNotifier>(context, listen: false)
        //     .getSingleUser();

        Navigator.of(context).pushReplacement(DokumentApiPage.route());
      } else {
        Navigator.of(context).pushReplacement(AuthPage.route());
      }

      return null;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          Text('SplashScreenPage'),
        ],
      ),
    );
  }
}
