import 'package:flutter/material.dart';
import 'package:flutter_real_estate/ui/components/bottom_app_bar.dart';
import 'package:flutter_real_estate/ui/components/strings.dart';
import 'package:flutter_real_estate/ui/components/top_app_bar.dart';
import 'package:flutter_real_estate/ui/screens/about_screen.dart';
import 'package:flutter_real_estate/ui/screens/overview_screen.dart';
import 'package:flutter_real_estate/ui/theme/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import 'application/selected_index_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizerUtil.setScreenSize(constraints, orientation);
            return MaterialApp(
              theme: ThemeData(
                fontFamily: 'GothamSSm',
                scaffoldBackgroundColor: AppColors.lightGray,
              ),
              home: HomePage(),
            );
          },
        );
      },
    );
  }
}

class HomePage extends ConsumerWidget {
  final List<Widget> screens = [OverviewScreen(), AboutScreen()];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Which widget to show on screen
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Scaffold(
        appBar: TopAppBar(title: Strings.appBarTitles[selectedIndex]),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: screens.elementAt(selectedIndex),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBarMenu());
  }
}
