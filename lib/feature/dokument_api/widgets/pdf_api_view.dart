import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

import '../../../utils/logger.dart';

class PdfApiView extends StatefulWidget {
  const PdfApiView({super.key, required this.url, required this.idDocument});
  final String url;
  final String idDocument;

  @override
  State<PdfApiView> createState() => _PdfApiViewState();
}

class _PdfApiViewState extends State<PdfApiView> {
  // filePath: widget.file.path,
  var filePath;
  @override
  void initState() {
    logger.d('url = ${widget.url}');
    // createFileOfPdfUrl().then((value) {
    //   setState(() {
    //     filePath = value.path;
    //   });
    // });
    super.initState();
  }

  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.idDocument),
      ),
      body: FutureBuilder(
          future: createFileOfPdfUrl(widget.url),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (errorMessage.isNotEmpty) {
              return Center(child: Text('tidak daoat memuat file pdf'));
            }
            return PDFView(
              filePath: snapshot.data?.path,
              onError: (error) {
                setState(() {
                  errorMessage = error.toString();
                });
                logger.e(error.toString());
              },
            );
          }),
    );
  }

  Future<File> createFileOfPdfUrl(String url) async {
    Completer<File> completer = Completer();
    logger.d("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      // var url = "https://www.africau.edu/images/default/sample.pdf";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      logger.d("Download files");
      logger.d("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}
