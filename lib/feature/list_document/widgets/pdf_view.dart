import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class DetailDocumentPdfView extends StatefulWidget {
  final File file;

  const DetailDocumentPdfView({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  State<DetailDocumentPdfView> createState() => _DetailDocumentPdfViewState();
}

class _DetailDocumentPdfViewState extends State<DetailDocumentPdfView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PDFView(
        filePath: widget.file.path,
      ),
    );
  }
}
