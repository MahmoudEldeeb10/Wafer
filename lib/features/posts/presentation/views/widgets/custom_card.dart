import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wafer/core/utils/styles.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String text;
  final String imagePath;

  const CustomCard({
    super.key,
    required this.title,
    required this.text,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Image.asset(imagePath, width: 35, height: 35),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Styles.textStyle18),
                    const SizedBox(height: 6),
                    Text(text, style: Styles.textStyle14),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
