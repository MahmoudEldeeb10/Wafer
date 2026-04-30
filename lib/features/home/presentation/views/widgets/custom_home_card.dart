import 'package:flutter/material.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/core/utils/styles.dart';

class CustomHomeCard extends StatelessWidget {
  final String title;
  final String productName;
  final int quantity;
  final String? imageUrl;

  const CustomHomeCard({
    super.key,
    required this.title,
    required this.productName,
    required this.quantity,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصورة
          ClipRRect(
            child: imageUrl != null
                ? Image.network(
                    imageUrl!,
                    width: 130,
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _placeholder(),
                  )
                : _placeholder(),
          ),
          // النص
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Styles.textStyle18),
                  const SizedBox(height: 6),
                  Text('المنتج: $productName', style: Styles.textStyle14),
                  const SizedBox(height: 4),
                  Text('الكمية: $quantity', style: Styles.textStyle14),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryText,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'الحصول على العرض',
                        style: Styles.textStyle14.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 130,
      height: 180,
      color: const Color(0xFFEDE7F6),
      child: const Icon(
        Icons.volunteer_activism,
        color: Color(0xFF6C2CB9),
        size: 40,
      ),
    );
  }
}
