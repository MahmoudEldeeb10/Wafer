import 'package:flutter/material.dart';
import 'package:wafer/core/utils/styles.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final IconData firstIcon;
  final IconData secondIcon;
  final VoidCallback? onFirstIconTap; // أضف الـ callback
  final VoidCallback? onSecondIconTap;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.firstIcon,
    required this.secondIcon,
    this.onFirstIconTap,
    this.onSecondIconTap,
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
        GestureDetector(
          onTap: onFirstIconTap,
          child: Icon(
            firstIcon,
            size: 28,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: onSecondIconTap,
          child: Icon(
            secondIcon,
            size: 28,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
