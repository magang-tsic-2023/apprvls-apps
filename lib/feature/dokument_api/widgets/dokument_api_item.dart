import 'package:app_ui/app_ui.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laporan_check_apps/feature/dokument_api/widgets/pdf_api_view.dart';
import 'package:laporan_check_apps/feature/dokument_api/widgets/text_field_custom.dart';
import 'package:laporan_check_apps/models/documentApi/document_api.dart';
import 'package:laporan_check_apps/utils/constants.dart';
import 'package:laporan_check_apps/utils/logger.dart';

import '../../../models/api_tsic/document/document_model_all.dart';
import '../../../utils/cek_admin_level.dart';
import '../../../utils/pref.dart';
import '../provider/dokument_api_provider.dart';
import '../provider/provider.dart';
import 'itemAdmin.dart';
import 'package:laporan_check_apps/utils/extention.dart';

class DokumenApiItem extends StatefulWidget {
  const DokumenApiItem({
    super.key,
    required this.singleDocumentModelTsic,
  });
  final SingleDocumentModelTsic? singleDocumentModelTsic;

  @override
  State<DokumenApiItem> createState() => _DokumenApiItemState();
}

class _DokumenApiItemState extends State<DokumenApiItem> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box(Constants.hiveUserDb);
    var userLogin = box.get(Constants.hiveRole);
    return Consumer<DokumentApiNotifier>(builder: (context, state, child) {
      return Card(
        child: ExpansionTile(
          title: Row(
            children: [
              Text('${widget.singleDocumentModelTsic?.no}.'),
              Text(widget.singleDocumentModelTsic?.name ?? '-'),
            ],
          ),
          subtitle: Text(widget.singleDocumentModelTsic?.createdAt?.toLokal() ??
              'Sabtu, 04 Februari 2023 '),
          // trailing: Icon(Icons.check_box_outline_blank),
          children: [
            Row(
              children: [
                if (Prefs().role == 1)
                  TextButton(
                      onPressed: () {
                        editFileDokumen(widget.singleDocumentModelTsic?.id);
                      },
                      child: Icon(
                        Icons.edit,
                        color: LaporanCheckColors.green,
                      )),
                Expanded(
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => PdfApiView(
                                  url: widget.singleDocumentModelTsic?.url ??
                                      '-',
                                  idDocument:
                                      widget.singleDocumentModelTsic?.id ?? '-',
                                )));
                      },
                      child: Text('Lihat Dokumen')),
                ),
                // if (Prefs().role == 1)
                //   TextButton(
                //       onPressed: () {
                //         hapusFileDokumen(
                //             widget.singleDocumentModelTsic?.id ?? '-');
                //       },
                //       child: Icon(
                //         Icons.delete,
                //         color: LaporanCheckColors.secondary,
                //       )),
              ],
            ),

            // ItemAdmin(
            //     nama:
            //         'Admin ${widget.singleDocumentModelTsic?.approvalsList?[0].level}',
            //     statusApprove:
            //         widget.singleDocumentModelTsic?.approvalsList?[0].status,
            //     onTap: (Prefs().role == 1)
            //         ? () {
            //             showAdmin(Constants.roleAdmin1);
            //           }
            //         : () {
            //             approveAdminFileDokumen(
            //                 admin: Constants.roleAdmin1,
            //                 statusApprove: widget.singleDocumentModelTsic
            //                     ?.approvalsList?[0].status,
            //                 idApproval: widget
            //                     .singleDocumentModelTsic?.approvalsList?[0].id);
            //           }),
            // ItemAdmin(
            //     nama:
            //         'Admin ${widget.singleDocumentModelTsic?.approvalsList?[1].level}',
            //     statusApprove:
            //         widget.singleDocumentModelTsic?.approvalsList?[1].status,
            //     onTap: (Prefs().role == 1)
            //         ? () {
            //             showAdmin(Constants.roleAdmin2);
            //           }
            //         : () {
            //             approveAdminFileDokumen(
            //                 admin: Constants.roleAdmin2,
            //                 statusApprove: widget.singleDocumentModelTsic
            //                     ?.approvalsList?[1].status,
            //                 idApproval: widget
            //                     .singleDocumentModelTsic?.approvalsList?[0].id);
            //           }),
            // // ItemAdmin(
            //     nama: 'Admin 3',
            //     statusApprove: widget.singleDocumentModelTsic?.approvalsList?[0].status,
            //     onTap: (userLogin != Constants.roleAdmin3)
            //         ? () {
            //             showAdmin(Constants.roleAdmin3);
            //           }
            //         : () {
            //             approveAdminFileDokumen(
            //                 admin: Constants.roleAdmin3,
            //                 statusApprove:
            //                     widget.singleDocumentModelTsic?.approvalsList?[0].status);
            //           }),
            ...widget.singleDocumentModelTsic?.approvalsList?.map(
                  (e) => ItemAdmin(
                      statusApprove: e.status,
                      nama: CekAdminStatus().cekStatusRole(e.level),
                      onTap: (Prefs().role == 1)
                          ? () {
                              showAdmin("admin");
                            }
                          : () {
                              approveAdminFileDokumen(
                                state: state,
                                admin: Constants.roleAdmin1,
                                statusApprove: e.status,
                                idApproval: e.id,
                              );
                            }),
                ) ??
                []
          ],
        ),
      );
    });
  }

  editFileDokumen(String? idDocument) {
    TextEditingController name =
        TextEditingController(text: widget.singleDocumentModelTsic?.name);

    TextEditingController url =
        TextEditingController(text: widget.singleDocumentModelTsic?.url);
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.rightSlide,
      // title: 'Hapus',
      // desc: 'Yakin hapus dokumen ?',
      body: Column(
        children: [
          Text('Edit dokumen'),
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
        // Provider.of<DokumentApiNotifier>(context, listen: false)
        //     .updateDocumentApiSample(widget.documentAllModelTsic?.copyWith(
        //           name: name.text,
        //           url: url.text,
        //           updatedAt: DateTime.now().toLokal(),
        //         ) ??
        //         DocumentApi());
        Provider.of<DokumentApiNotifier>(context, listen: false)

            /// 0 approve 1 pending 2 rejek
            .updateDocument(
                name: name.text, url: url.text, idDocument: idDocument);
      },
    ).show().then((value) {
      Provider.of<DokumentApiNotifier>(context, listen: false).getDocument();

      name.clear();
      url.clear();
    });
  }

  hapusFileDokumen(String? idDocumet) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: 'Hapus',
      desc: 'Yakin hapus dokumen ${widget.singleDocumentModelTsic?.name} ?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        // Provider.of<DokumentApiNotifier>(context, listen: false)
        //     .deleteDocumentApiSample(widget.documentAllModelTsic);
        Provider.of<DokumentApiNotifier>(context, listen: false)

            /// 0 approve 1 pending 2 rejek
            .deleteDocument(idDocument: idDocumet);
      },
    ).show().then((value) {
      Provider.of<DokumentApiNotifier>(context, listen: false).getDocument();
    });
  }

  showAdmin(String admin) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: 'Khusus $admin',
      desc: 'hanya tersedia untuk $admin',
      // btnCancelOnPress: () {},
      // btnOkOnPress: () {
      //   // Provider.of<DokumentApiNotifier>(context, listen: false).addDocumentApi(
      //   //   DocumentApi(name: name.text, url: url.text),
      //   // );
      // },
    ).show();
  }

  approveAdminFileDokumen(
      {required DokumentApiNotifier? state,
      String? admin,
      int? statusApprove,
      required String? idApproval}) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: 'Approve',
      desc: 'Yakin approve dokumen ${widget.singleDocumentModelTsic?.name} ?',
      btnOkText: 'Approve',
      btnCancelText: 'Reject',
      btnCancelOnPress: () {
        switch (admin) {
          case Constants.roleAdmin3:
          case Constants.roleAdmin2:
          case Constants.roleAdmin1:
            Provider.of<DokumentApiNotifier>(context, listen: false)

                /// 0 approve 1 pending 2 rejek
                .updateApproval(status: 2, idApproval: idApproval)
                .then((value) {
              state?.getDocument();
            });
            break;
          default:
        }
      },
      btnOkOnPress: () {
        switch (admin) {
          case Constants.roleAdmin1:
          //   Provider.of<DokumentApiNotifier>(context, listen: false)

          //       /// 0 approve 1 pending 2 rejek
          //       .updateApproval(status: 0, idApproval: idApproval);

          //   break;
          // case Constants.roleAdmin2:
          //   Provider.of<DokumentApiNotifier>(context, listen: false)

          //       /// 0 approve 1 pending 2 rejek
          //       .updateApproval(status: 0, idApproval: idApproval);

          //   break;
          case Constants.roleAdmin3:
            Provider.of<DokumentApiNotifier>(context, listen: false)

                /// 0 approve 1 pending 2 rejek
                .updateApproval(status: 0, idApproval: idApproval)
                .then((value) {
              state?.getDocument();
            });

            break;
          default:
        }
      },
    ).show().then((value) {
      if (value != null) {
        state?.getDocument();
      }
    });
  }
}
