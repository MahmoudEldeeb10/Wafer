import 'package:flutter/material.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/core/utils/styles.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final IconData firstIcon;
  final IconData secondIcon;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.firstIcon,
    required this.secondIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: Styles.textStyle30.copyWith(fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Icon(firstIcon, size: 30, color: Colors.black),
        SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.primaryText,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(secondIcon, size: 30, color: AppColors.fourthText),
        ),
      ],
    );
  }
}
