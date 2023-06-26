import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      elevation: 0.0,
      currentIndex: currentIndex,
      onTap: (index) => onItemTapped(index),
      selectedItemColor: colors.primary,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: "Inicio",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.thumbs_up_down_outlined),
          label: "Populares",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: "Favoritos",
        ),
      ],
    );
  }
}
