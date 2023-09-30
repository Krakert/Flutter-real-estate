import 'package:flutter/material.dart';

import '../../main.dart';
import '../theme/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome(context);
  }

  Future<void> navigateToHome(BuildContext context) async {
    // Simulate a delay for the splash screen
    await Future.delayed(const Duration(seconds: 2));
    // Navigate to the home screen
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dttRed,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //DTT Logo
            Image.asset(
              'assets/images/launcher_icon.png',
              width: 80,
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
