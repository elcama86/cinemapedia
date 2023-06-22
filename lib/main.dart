import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cinemapedia/config/router/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  await dotenv.load(fileName: ".env");
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
