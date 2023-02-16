import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:laporan_check_apps/feature/list_document/widgets/preview_document.dart';
import 'package:laporan_check_apps/utils/logger.dart';
import 'package:provider/provider.dart';

import '../provider/list_document_provider.dart';

class ButtonTambahFile extends StatelessWidget {
  const ButtonTambahFile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ListDocumentNotifier>(builder: (context, state, child) {
      return FloatingActionButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();

          if (result != null) {
            var size = result.files.first.size;
            logger.d('size $size');
            if (size > 16000000) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('file maksimal 16 Mb')));
              return;
            }
            // ignore: use_build_context_synchronously
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PreviewDocument(
                  nameFile: result.files.single.name,
                  file: File(result.files.single.path ?? ''),
                ),
              ),
            );
          } else {
            // User canceled the picker
          }
        },
        child: Icon(Icons.note_add_outlined),
      );
    });
  }
}
