import 'package:flutter/material.dart';
import 'package:wafer/core/widgets/custom_app_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              CustomAppBar(
                title: 'المــلــف الشــخــصــي',
                firstIcon: Icons.search,
                secondIcon: Icons.notifications_outlined,
              ),
            ],
          ),
        ),edit 
      ),
    );
  }
}