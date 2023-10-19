import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/selected_index_provider.dart';
import '../theme/colors.dart';

class BottomAppBarMenu extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

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
      onTap: (index) {
        ref.read(selectedIndexProvider.notifier).state = index;
      },
    );
  }
}
