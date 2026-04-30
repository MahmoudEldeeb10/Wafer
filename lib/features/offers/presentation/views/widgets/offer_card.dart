import 'package:flutter/material.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/features/offers/data/models/offer_model.dart';

class OfferCard extends StatelessWidget {
  final OfferModel offer;

  const OfferCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// العنوان + صورة صغيرة
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey.shade200,
                  child: const Icon(Icons.store),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    offer.donorOrganizationName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// التفاصيل
            Text('المنتج: ${offer.productName}'),
            Text('الكمية: ${offer.quantity}'),
            Text('المحافظة: ${offer.governorate ?? "غير محدد"}'),
            Text('تاريخ الانتهاء: ${offer.expiryDate}'),

            const SizedBox(height: 12),

            /// زرار
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryText,
                ),
                child: const Text(
                  'الحصول على العرض',
                  style: TextStyle(color: AppColors.fourthText),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
