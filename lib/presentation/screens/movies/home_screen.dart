import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static const String name = "home-screen";

  final StatefulNavigationShell navigationShell;

  const HomeScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
