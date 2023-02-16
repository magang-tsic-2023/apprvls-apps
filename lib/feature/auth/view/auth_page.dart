import 'package:flutter/material.dart';
import 'package:laporan_check_apps/feature/auth/provider/provider.dart';
import 'package:laporan_check_apps/feature/auth/widgets/auth_body.dart';

/// {@template auth_page}
/// A description for AuthPage
/// {@endtemplate}
class AuthPage extends StatelessWidget {
  /// {@macro auth_page}
  const AuthPage({Key? key}) : super(key: key);

  /// The static route for AuthPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const AuthPage());
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) =>
          ChangeNotifierProvider(create: (_) => AuthNotifier()),
      child: const Scaffold(
        body: AuthView(),
      ),
    );
  }
}

/// {@template auth_view}
/// Displays the Body of AuthView
/// {@endtemplate}
class AuthView extends StatelessWidget {
  /// {@macro auth_view}
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthBody();
  }
}
