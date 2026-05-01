import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wafer/core/utils/styles.dart';
import 'package:wafer/features/auth/presentation/view/login_screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/wafer_logo.png',
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}

//  وافر ف اللوجو بس مش هتبقي ف النص ب الظبط
//  Stack(
//               alignment: Alignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/wafer_logo.png',
//                   height: MediaQuery.of(context).size.height * 0.3,
//                   width: double.infinity,
//                 ),
//                 Image.asset('assets/images/wafer_white_text.png'),
//               ],
//             ),
