import 'package:flutter/material.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/core/utils/styles.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String category;
  final String description;
  final String? imagePath;
  final String time;
  final int? status;

  const CustomCard({
    super.key,
    required this.title,
    required this.category,
    required this.description,
    this.imagePath,
    required this.time,
    this.status,
  });

  String _formatDate(String date) {
    try {
      final dt = DateTime.parse(date);
      return '${dt.day}/${dt.month}/${dt.year}';
    } catch (_) {
      return date;
    }
  }

  String _getStatusText(int status) {
    const texts = {0: 'قيد المراجعة', 1: 'مقبولة', 2: 'مرفوضة', 3: 'مكتملة'};
    return texts[status] ?? '';
  }

  Color _getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.orange;
      case 1:
        return Colors.green;
      case 2:
        return Colors.red;
      case 3:
        return AppColors.primaryText;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: imagePath != null
                    ? NetworkImage(imagePath!) as ImageProvider
                    : const AssetImage('assets/images/test.png'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Styles.textStyle18),
                    const SizedBox(height: 3),
                    Text(
                      _formatDate(time),
                      style: Styles.textStyle14.copyWith(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// Category
          Text(
            category,
            textAlign: TextAlign.right,
            style: Styles.textStyle16.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),

          const SizedBox(height: 8),

          /// Description
          Text(
            description,
            textAlign: TextAlign.right,
            style: Styles.textStyle14.copyWith(
              color: Colors.grey.shade800,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 10),
          Text(
            'عرض المزيد',
            style: Styles.textStyle14.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primaryText,
            ),
          ),

          /// Status Badge
          if (status != null) ...[
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(status!).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _getStatusColor(status!)),
                ),
                child: Text(
                  _getStatusText(status!),
                  style: Styles.textStyle14.copyWith(
                    color: _getStatusColor(status!),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],


        ],
      ),
    );
  }
}