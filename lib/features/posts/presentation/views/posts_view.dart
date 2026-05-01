import 'package:flutter/material.dart';
import 'package:wafer/core/widgets/custom_app_bar.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomAppBar(
              title: 'المنشــــــورات',
              firstIcon: Icons.search,
              secondIcon: Icons.add,
            ),
          ],
        ),
      ),
    );
  }
}

