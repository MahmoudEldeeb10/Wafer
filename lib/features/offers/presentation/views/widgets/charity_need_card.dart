import 'package:flutter/material.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/features/offers/data/models/charity_need_model.dart';
import 'package:wafer/features/offers/presentation/views/widgets/charity_need_details_bottom_sheet.dart';

class CharityNeedCard extends StatelessWidget {
  final CharityNeedModel need;

  const CharityNeedCard({super.key, required this.need});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.all(12),
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
            // ── صورة المنتج ──────────────────────────────────
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: need.productImage != null
                  ? Image.network(
                      need.productImage!,
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _PlaceholderImage(),
                    )
                  : _PlaceholderImage(),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── اسم الجمعية + priority badge ──────────
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          need.charityName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      _PriorityBadge(priority: need.priority),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // ── اسم المنتج ────────────────────────────
                  Text(
                    need.productName,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 8),

                  // ── الكمية + الموقع ───────────────────────
                  Row(
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 13,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${need.quantity} ${_unitLabel(need.unit)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.location_on_outlined,
                        size: 13,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${need.governorate ?? ''} — ${need.city ?? ''}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ── زرار ─────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => CharityNeedDetailsBottomSheet(
                            charityNeedId: need.charityNeedId,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryText,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'تقديم تبرع',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _unitLabel(int unit) {
    const units = {
      0: 'ملجم',
      1: 'كجم',
      2: 'طن',
      3: 'لتر',
      4: 'مل',
      5: 'كرتونة',
      6: 'قطعة',
      7: 'علبة',
      8: 'حبة',
    };
    return units[unit] ?? 'وحدة';
  }
}

class _PlaceholderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      color: const Color(0xFFE1F5EE),
      child: const Icon(
        Icons.image_not_supported_outlined,
        size: 40,
        color: Color(0xFF0F6E56),
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  final int priority;

  const _PriorityBadge({required this.priority});

  @override
  Widget build(BuildContext context) {
    final isUrgent = priority == 1;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isUrgent ? const Color(0xFFFAEEDA) : const Color(0xFFE1F5EE),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        isUrgent ? 'عاجل' : 'عادي',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isUrgent ? const Color(0xFF854F0B) : const Color(0xFF0F6E56),
        ),
      ),
    );
  }
}
