import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laporan_check_apps/feature/dokument_api/provider/provider.dart';
import 'package:laporan_check_apps/utils/pref.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../models/documentApi/document_api.dart';
import '../../../utils/constants.dart';
import 'dokument_api_item.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'text_field_custom.dart';

/// {@template dokument_api_body}
/// Body of the DokumentApiPage.
///
/// Add what it does
/// {@endtemplate}
class DokumentApiBody extends StatefulWidget {
  /// {@macro dokument_api_body}
  const DokumentApiBody({super.key});

  @override
  State<DokumentApiBody> createState() => _DokumentApiBodyState();
}

class _DokumentApiBodyState extends State<DokumentApiBody> {
  late Future _getDocument;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<DokumentApiNotifier>(context, listen: false)
    //     .getListDocumentSample();
    _getDocument =
        Provider.of<DokumentApiNotifier>(context, listen: false).getDocument();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DokumentApiNotifier>(
      builder: (context, state, child) {
        return RefreshIndicator(
          onRefresh: () async {
            state.getDocument();
          },
          child: FutureBuilder(
              future: _getDocument,
              builder: (context, snapshot) {
                return ModalProgressHUD(
                  inAsyncCall: state.loading,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.listDocumentTsic?.length ?? 0,
                          itemBuilder: (_, index) => DokumenApiItem(
                            singleDocumentModelTsic:
                                state.listDocumentTsic?[index],
                          ),
                        ),
                      ),
                      if (Prefs().role == 1)
                        ElevatedButton(
                            onPressed: () {
                              addFileDokumen(state);
                            },
                            child: Text('Tambah'))
                    ],
                  ),
                );
              }),
        );
      },
    );
  }

  TextEditingController name = TextEditingController();
  TextEditingController url = TextEditingController();

  addFileDokumen(DokumentApiNotifier state) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.rightSlide,
      // title: 'Hapus',
      // desc: 'Yakin hapus dokumen ?',
      body: Column(
        children: [
          Text('Tambah dokumen'),
          SizedBox(
            height: 20,
          ),
          TextFieldCustom(
              controller: name,
              label: 'Nama dokumen',
              hint: 'masukkan nama dokumen'),
          TextFieldCustom(
              controller: url,
              label: 'Url dokumen',
              hint: 'masukkan url dokumen'),
        ],
      ),
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Provider.of<DokumentApiNotifier>(context, listen: false)
            .addDocument(name: name.text, url: url.text)
            .then((value) {
          Provider.of<DokumentApiNotifier>(context, listen: false)
              .getDocument();
        });
      },
    ).show().then((value) {
      // Provider.of<DokumentApiNotifier>(context, listen: false).getDocument();
      name.clear();
      url.clear();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
