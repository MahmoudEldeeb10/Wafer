import 'package:flutter/material.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/core/utils/styles.dart';

class RequestCard extends StatelessWidget {
  final String title;
  final String description;
  final String phone;
  final String location;

  const RequestCard({
    super.key,
    required this.title,
    required this.description,
    required this.phone,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// Title Row
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/test.png'),
              ),
              const Spacer(),
              Text(
                title,
                textAlign: TextAlign.right,
                style: Styles.textStyle18,
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// Details
          Text(
            "العرض: $description",
            textAlign: TextAlign.right,
            style: Styles.textStyle14,
          ),
          const SizedBox(height: 6),
          Text(
            "· رقم التواصل: $phone",
            textAlign: TextAlign.right,
            style: Styles.textStyle14,
          ),
          const SizedBox(height: 6),
          Text(
            "· الموقع: $location",
            textAlign: TextAlign.right,
            style: Styles.textStyle14,
          ),

          const SizedBox(height: 14),

          /// Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "رفض",
                    style: TextStyle(
                      color: AppColors.fourthText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "قبول",
                    style: TextStyle(
                      color: AppColors.fourthText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}