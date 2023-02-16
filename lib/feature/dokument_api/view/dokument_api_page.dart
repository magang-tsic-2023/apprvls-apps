import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laporan_check_apps/feature/dokument_api/provider/provider.dart';
import 'package:laporan_check_apps/feature/dokument_api/widgets/dokument_api_body.dart';
import 'package:laporan_check_apps/models/documentApi/document_api.dart';
import 'package:laporan_check_apps/utils/pref.dart';

import '../../../utils/constants.dart';
import '../../auth/auth.dart';

/// {@template dokument_api_page}
/// A description for DokumentApiPage
/// {@endtemplate}
class DokumentApiPage extends StatelessWidget {
  /// {@macro dokument_api_page}
  const DokumentApiPage({super.key});

  /// The static route for DokumentApiPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const DokumentApiPage());
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box(Constants.hiveUserDb);

    return Consumer<DokumentApiNotifier>(builder: (context, state, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('List document -  ${box.get(Constants.hiveName)}'),
          actions: [
            IconButton(
              onPressed: () {
                state.getDocument();
              },
              icon: Icon(Icons.refresh),
            ),
            IconButton(
              onPressed: () {
                logout(context);
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: DokumentApiView(),
      );
    });
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
    ).show();
  }
}

/// {@template dokument_api_view}
/// Displays the Body of DokumentApiView
/// {@endtemplate}
class DokumentApiView extends StatelessWidget {
  /// {@macro dokument_api_view}
  const DokumentApiView({super.key});

  @override
  Widget build(BuildContext context) {
    return DokumentApiBody();
  }
}
