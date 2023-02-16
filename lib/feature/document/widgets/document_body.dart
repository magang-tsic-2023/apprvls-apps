import 'package:flutter/material.dart';
import 'package:laporan_check_apps/feature/document/provider/provider.dart';

/// {@template document_body}
/// Body of the DocumentPage.
///
/// Add what it does
/// {@endtemplate}
class DocumentBody extends StatelessWidget {
  /// {@macro document_body}
  const DocumentBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DocumentNotifier>(
      builder: (context, state, child) {
        return Text(state.count.toString());
      },
    );
  }
}
