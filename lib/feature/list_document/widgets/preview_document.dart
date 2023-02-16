import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laporan_check_apps/feature/list_document/widgets/pdf_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../utils/constants.dart';
import '../list_document.dart';

class PreviewDocument extends StatefulWidget {
  const PreviewDocument(
      {super.key, required this.file, required this.nameFile});

  final File file;
  final String nameFile;

  @override
  State<PreviewDocument> createState() => _PreviewDocumentState();
}

class _PreviewDocumentState extends State<PreviewDocument> {
  TextEditingController title = TextEditingController();
  @override
  void initState() {
    super.initState();
    title.text = widget.nameFile;
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box(Constants.hiveUserDb);
    return Consumer<ListDocumentNotifier>(builder: (context, state, child) {
      return ModalProgressHUD(
        inAsyncCall: state.loading,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Preview Document'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Nama file',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                      )),
                  controller: title,
                ),
              ),
              Expanded(
                child: DetailDocumentPdfView(
                  file: widget.file,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    title: 'Upload file?',
                    desc: 'Yakin upload dokumen " ${title.text} "?',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      context
                          .read<ListDocumentNotifier>()
                          .insertDocument(
                            file: widget.file,
                            name: '${title.text}',
                          )
                          .then((value) => state.getDocument())
                          .then((value) {
                        Navigator.of(context).pop();
                      });
                    },
                  )..show();
                },
                child: Text('Upload'),
              ),
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
}
