import 'package:flutter/material.dart';
import 'package:flutter_real_estate/ui/components/bottom_app_bar.dart';
import 'package:flutter_real_estate/ui/components/top_app_bar.dart';
import 'package:flutter_real_estate/ui/screens/about_screen.dart';
import 'package:flutter_real_estate/ui/screens/overview_screen.dart';
import 'package:flutter_real_estate/ui/screens/splash_screen.dart';
import 'package:flutter_real_estate/ui/theme/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

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
              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;
  List appBarTitles = ['DTT REAL ESTATE', 'ABOUT'];
  List screens = [OverviewScreen(), AboutScreen()];
  bool isLocationPermissionAllowed = true;

  void onClicked(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopAppBar(title: appBarTitles[selectedIndex]),
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
        bottomNavigationBar: BottomAppBarMenu(
          selectedIndex: selectedIndex,
          onClicked: onClicked,
        ));
  }
}
