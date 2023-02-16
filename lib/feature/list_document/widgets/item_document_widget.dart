import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:laporan_check_apps/utils/constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../../models/document_model.dart';
import '../../../utils/check_status_helper.dart';
import '../list_document.dart';

class ItemDocumentWidget extends StatelessWidget {
  const ItemDocumentWidget({
    super.key,
    required this.onPress,
    required this.title,
    required this.trailing,
    this.subTitle,
    required this.documentModel,
  });
  final DocumentModel documentModel;
  final Function onPress;
  final Widget title;
  final Widget trailing;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    var box = Hive.box(Constants.hiveUserDb);

    return Consumer<ListDocumentNotifier>(builder: (
      context,
      state,
      _,
    ) {
      return Dismissible(
        key: Key(documentModel.id.toString()),
        // onDismissed: (direction) {
        //   //
        // },
        confirmDismiss: (direction) async {
          (box.get(Constants.hiveRole) == Constants.roleUser)
              ? delete(state, context).then((value) => true)
              : () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    title: 'Khusus role user',
                    desc: 'hanya role user yang dapat menghapus',
                  )..show().then((value) {
                      return false;
                    });
                };
          // return true;
        },
        child: ListTile(
          onTap: () {
            onPress();
          },
          title: title,
          subtitle: Text(subTitle ?? '-'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Tooltip(
                  message: 'approve admin1',
                  child: admin1(box, state, context)),
              SizedBox(
                width: 10,
              ),
              Tooltip(
                  message: 'approve admin2',
                  child: admin2(box, state, context)),
            ],
          ),
        ),
      );
    });
  }

  IconButton admin1(box, ListDocumentNotifier state, BuildContext context) {
    return IconButton(
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
                  state
                      .updateDocument(
                        documentModel.copyWith(
                            id: ObjectId.fromHexString(
                                documentModel.id?.toHexString() ?? ''),
                            approveAdmin1: Constants.reject,
                            approveAdmin1Name: box.get(Constants.hiveName)),
                      )
                      .then(
                        (value) => state.getDocument(),
                      );
                },
                btnOkOnPress: () {
                  state
                      .updateDocument(
                        documentModel.copyWith(
                            approveAdmin1: Constants.approve,
                            approveAdmin1Name: box.get(Constants.hiveName)),
                      )
                      .then(
                        (value) => state.getDocument(),
                      );
                },
              )..show();
            }
          : null,
      icon: CheckStatusHelper()
          .checkStatus(documentModel.approveAdmin1 ?? Constants.pending),
    );
  }

  IconButton admin2(box, ListDocumentNotifier state, BuildContext context) {
    return IconButton(
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
                  state
                      .updateDocument(
                        documentModel.copyWith(
                            approveAdmin2: Constants.reject,
                            approveAdmin2Name: box.get(Constants.hiveName)),
                      )
                      .then(
                        (value) => state.getDocument(),
                      );
                },
                btnOkOnPress: () {
                  state
                      .updateDocument(
                        documentModel.copyWith(
                            approveAdmin2: Constants.approve,
                            approveAdmin2Name: box.get(Constants.hiveName)),
                      )
                      .then(
                        (value) => state.getDocument(),
                      );
                },
              )..show();
            }
          : null,
      icon: CheckStatusHelper()
          .checkStatus(documentModel.approveAdmin2 ?? Constants.pending),
    );
  }

  Future delete(ListDocumentNotifier state, BuildContext context) async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      title: 'Delete',
      desc: 'Delete ${documentModel.name}?',
      btnCancelText: 'Cancel',
      btnOkText: 'Delete',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        state
            .deleteDocument(
              documentModel,
            )
            .then(
              (value) => state.getDocument(),
            );
      },
    )..show();
  }
}
