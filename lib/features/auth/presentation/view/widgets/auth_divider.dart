import 'package:flutter/material.dart';
import 'package:wafer/core/utils/app_colors.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: AppColors.tertiaryText, thickness: 1),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'أو',
            style: TextStyle(fontSize: 14, color: AppColors.tertiaryText),
          ),
        ),
        const Expanded(
          child: Divider(color: AppColors.tertiaryText, thickness: 1),
        ),
      ],
    );
  }
}
