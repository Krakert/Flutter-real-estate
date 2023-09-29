import 'package:flutter/material.dart';

import '../theme/colors.dart';

class BottomAppBarMenu extends StatelessWidget {
  final int selectedIndex;
  ValueChanged<int> onClicked;
  BottomAppBarMenu({required this.selectedIndex, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'Info',
        ),
      ],
      currentIndex: selectedIndex,

      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.strong,
      unselectedItemColor: AppColors.light,

      showSelectedLabels: false,
      showUnselectedLabels: false,

      onTap: onClicked,
    );
  }

}
