import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:laporan_check_apps/feature/list_document/provider/provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../services/mongo_db_document_services.dart';
import '../../../utils/locator.dart';
import 'detail_document.dart';
import 'item_document_widget.dart';
import 'package:laporan_check_apps/utils/extention.dart';

/// {@template list_document_body}
/// Body of the ListDocumentPage.
///
/// Add what it does
/// {@endtemplate}
class ListDocumentBody extends StatefulWidget {
  /// {@macro list_document_body}
  const ListDocumentBody({Key? key}) : super(key: key);

  @override
  State<ListDocumentBody> createState() => _ListDocumentBodyState();
}

class _ListDocumentBodyState extends State<ListDocumentBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ListDocumentNotifier>(
      builder: (context, state, child) {
        return RefreshIndicator(
          onRefresh: () async {
            state.getDocument();
          },
          child: ModalProgressHUD(
            inAsyncCall: state.loading,
            child: (state.listDocument.isEmpty)
                ? Center(child: Text('No Data'))
                : ListView.builder(
                    itemCount: state.listDocument.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: ItemDocumentWidget(
                          documentModel: state.listDocument[index],
                          onPress: () async {
                            final file =
                                await locator<MongoDbDocumentServices>()
                                    .openFilePdf(
                              nama: state.listDocument[index].name ?? '-',
                              dataFile:
                                  state.listDocument[index].dataFile ?? '--',
                            );

                            // ignore: use_build_context_synchronously
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => DetailDocument(
                                  documentModel: state.listDocument[index],
                                  statusAdmin1:
                                      state.listDocument[index].approveAdmin1,
                                  statusAdmin2:
                                      state.listDocument[index].approveAdmin2,
                                  file: file,
                                ),
                              ),
                            );
                          },
                          title: Text(state.listDocument[index].name ?? '-'),
                          subTitle: DateTime.parse(
                                  state.listDocument[index].createdAt ??
                                      '0000-00-00')
                              .toLokal(),
                          trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                delete(state, index);
                              }),
                        ),
                      );
                    }),
          ),
        );
      },
    );
  }

  void delete(ListDocumentNotifier state, int index) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: 'Hapus',
      desc: 'Yakin hapus dokumen " ${state.listDocument[index].name} "?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        state
            .deleteDocument(state.listDocument[index])
            .then((value) => state.getDocument());
      },
    )..show();
  }
}
