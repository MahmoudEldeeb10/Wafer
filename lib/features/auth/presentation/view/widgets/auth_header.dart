import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Image.asset(
        'assets/images/wafer.png',
        height: MediaQuery.of(context).size.height * 0.15,
      ),
    );
  }
}
