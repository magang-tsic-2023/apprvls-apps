import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laporan_check_apps/feature/list_document/widgets/pdf_view.dart';
import 'package:laporan_check_apps/services/mongo_db_document_services.dart';
import 'package:laporan_check_apps/utils/check_status_helper.dart';
import 'package:laporan_check_apps/utils/locator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mongo_dart/mongo_dart.dart' show ObjectId;

import '../../../models/document_model.dart';
import '../../../services/socket_io_service.dart';
import '../../../utils/constants.dart';
import '../list_document.dart';

class DetailDocument extends StatefulWidget {
  const DetailDocument(
      {super.key,
      required this.documentModel,
      this.statusAdmin1,
      this.statusAdmin2,
      required this.file});

  final DocumentModel documentModel;
  final String? statusAdmin1;
  final String? statusAdmin2;
  final File file;

  @override
  State<DetailDocument> createState() => _DetailDocumentState();
}

class _DetailDocumentState extends State<DetailDocument> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box(Constants.hiveUserDb);
    return Consumer<ListDocumentNotifier>(builder: (context, state, child) {
      return ModalProgressHUD(
        inAsyncCall: state.loading,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Detail Document'),
          ),
          body: Column(
            children: [
              Text('${widget.documentModel.name}'),
              Expanded(
                child: DetailDocumentPdfView(
                  file: widget.file,
                ),
              ),
              admin1(box, context),
              ((box.get(Constants.hiveRole) != Constants.roleAdmin1))
                  ? admin2(box, context)
                  : const SizedBox()
            ],
          ),
        ),
      );
    });
  }

  void openPdf(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailDocumentPdfView(
            file: file,
          ),
        ),
      );

  Widget admin1(box, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Status Approve Admin 1: '),
        IconButton(
          onPressed: ((box.get(Constants.hiveRole) == Constants.roleAdmin1))
              ? () {
                  // ignore: avoid_single_cascade_in_expression_statements
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    title: 'Update',
                    desc: 'Approve atau Reject ?',
                    btnCancelText: 'Reject',
                    btnOkText: 'Approve',
                    btnCancelOnPress: () {
                      context
                          .read<ListDocumentNotifier>()
                          .updateDocument(
                            widget.documentModel.copyWith(
                                id: ObjectId.fromHexString(
                                    widget.documentModel.id?.toHexString() ??
                                        ''),
                                approveAdmin1: Constants.reject,
                                approveAdmin1Name: box.get(Constants.hiveName)),
                          )
                          .then(
                            (value) => context
                                .read<ListDocumentNotifier>()
                                .getDocument(),
                          )
                          .then((value) {
                        Navigator.of(context).pop();
                      });
                    },
                    btnOkOnPress: () {
                      context
                          .read<ListDocumentNotifier>()
                          .updateDocument(
                            widget.documentModel.copyWith(
                                approveAdmin1: Constants.approve,
                                approveAdmin1Name: box.get(Constants.hiveName)),
                          )
                          .then(
                            (value) => context
                                .read<ListDocumentNotifier>()
                                .getDocument(),
                          )
                          .then((value) {
                        Navigator.of(context).pop();
                      });
                    },
                  )..show();
                }
              : null,
          icon: CheckStatusHelper()
              .checkStatus(widget.statusAdmin1 ?? Constants.pending),
        ),
      ],
    );
  }

  Widget admin2(box, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Status Approve Admin 2: '),
        IconButton(
          onPressed: ((box.get(Constants.hiveRole) == Constants.roleAdmin2))
              ? () {
                  // ignore: avoid_single_cascade_in_expression_statements
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    title: 'Update',
                    desc: 'Approve atau Reject ?',
                    btnCancelText: 'Reject',
                    btnOkText: 'Approve',
                    btnCancelOnPress: () {
                      context
                          .read<ListDocumentNotifier>()
                          .updateDocument(
                            widget.documentModel.copyWith(
                                approveAdmin2: Constants.reject,
                                approveAdmin2Name: box.get(Constants.hiveName)),
                          )
                          .then(
                            (value) => context
                                .read<ListDocumentNotifier>()
                                .getDocument(),
                          )
                          .then((value) => Navigator.of(context).pop());
                    },
                    btnOkOnPress: () {
                      context
                          .read<ListDocumentNotifier>()
                          .updateDocument(
                            widget.documentModel.copyWith(
                              approveAdmin2: Constants.approve,
                              approveAdmin2Name: box.get(Constants.hiveName),
                            ),
                          )
                          .then(
                            (value) => context
                                .read<ListDocumentNotifier>()
                                .getDocument(),
                          )
                          .then((value) => Navigator.of(context).pop());
                    },
                  )..show();
                }
              : null,
          icon: CheckStatusHelper()
              .checkStatus(widget.statusAdmin2 ?? Constants.pending),
        ),
      ],
    );
  }
}
