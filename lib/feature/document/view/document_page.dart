import 'package:flutter/material.dart';
import 'package:laporan_check_apps/feature/document/provider/provider.dart';
import 'package:laporan_check_apps/feature/document/widgets/document_body.dart';

/// {@template document_page}
/// A description for DocumentPage
/// {@endtemplate}
class DocumentPage extends StatelessWidget {
  /// {@macro document_page}
  const DocumentPage({Key? key}) : super(key: key);

  /// The static route for DocumentPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const DocumentPage());
  }
 
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) =>
          ChangeNotifierProvider(create: (_) => DocumentNotifier()),
      child: const Scaffold(
        body: DocumentView(),
      ),
    );
  }   
}

/// {@template document_view}
/// Displays the Body of DocumentView
/// {@endtemplate}
class DocumentView extends StatelessWidget {
  /// {@macro document_view}
  const DocumentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DocumentBody();
  }
}
