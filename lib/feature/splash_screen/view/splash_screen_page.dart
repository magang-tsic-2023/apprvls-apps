import 'package:flutter/material.dart';
import 'package:laporan_check_apps/feature/splash_screen/widgets/splash_screen_body.dart';

/// {@template splash_screen_page}
/// A description for SplashScreenPage
/// {@endtemplate}
class SplashScreenPage extends StatelessWidget {
  /// {@macro splash_screen_page}
  const SplashScreenPage({Key? key}) : super(key: key);

  /// The static route for SplashScreenPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const SplashScreenPage());
  }
   
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreenView(),
    );
  } 
}

/// {@template splash_screen_view}
/// Displays the Body of SplashScreenView
/// {@endtemplate}
class SplashScreenView extends StatelessWidget {
  /// {@macro splash_screen_view}
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SplashScreenBody();
  }
}
