import 'package:flutter/material.dart';
import 'package:laporan_check_apps/feature/auth/provider/provider.dart';
import 'package:laporan_check_apps/feature/auth/widgets/password_field.dart';
import 'package:laporan_check_apps/feature/dokument_api/view/dokument_api_page.dart';
import 'package:laporan_check_apps/feature/dokument_api/widgets/dokument_api_item.dart';
import 'package:laporan_check_apps/feature/list_document/list_document.dart';
import 'package:laporan_check_apps/services/api_auth_tsic_services.dart';
import 'package:laporan_check_apps/utils/loading_helper.dart';
import 'package:laporan_check_apps/utils/locator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../dokument_api/dokument_api.dart';

/// {@template auth_body}
/// Body of the AuthPage.
///
/// Add what it does
/// {@endtemplate}
class AuthBody extends StatelessWidget {
  /// {@macro auth_body}
  AuthBody({Key? key}) : super(key: key);
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController userName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, state, child) {
        return ModalProgressHUD(
          inAsyncCall: state.loading,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text('Laporan Check Apps'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  )),
                  controller: userName,
                ),
              ),
              PasswordField(controller: password),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextField(
              //     obscureText: true,
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(
              //         30,
              //       ),
              //     )),
              //     controller: password,
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    // loginMongo(state,context);
                    loginApi(state, context);
                  },
                  child: Text('Login'))
            ],
          ),
        );
      },
    );
  }

  loginApi(AuthNotifier state, BuildContext context) {
    Navigator.of(context).pushReplacement(DokumentApiPage.route());
    state
        .loginApi(
      userName: userName.text,
      password: password.text,
    )
        .then((value) {
      if (value != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('sukses masuk')));
        // Provider.of<ListDocumentNotifier>(context, listen: false).getDocument();
        // Provider.of<DokumentApiNotifier>(context, listen: false).getDocument();
        // Provider.of<DokumentApiNotifier>(context, listen: false)
        //     .getSingleUser();
        // Provider.of<DokumentApiNotifier>(context, listen: false)
        //     .getDocument()
        //     .then((value) {
        //   Navigator.of(context).pushReplacement(DokumentApiPage.route());
        // });
        Navigator.of(context).pushReplacement(DokumentApiPage.route());
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('gagal masuk')));
      }
      return null;
    });
  }

  void loginMongo(AuthNotifier state, BuildContext context) {
    state
        .login(
      userName: userName.text,
      password: password.text,
    )
        .then((value) {
      if (value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('sukses masuk')));
        Navigator.of(context).pushReplacement(ListDocumentPage.route());
        Provider.of<ListDocumentNotifier>(context, listen: false).getDocument();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('gagal masuk')));
      }
      return null;
    });
  }
}
