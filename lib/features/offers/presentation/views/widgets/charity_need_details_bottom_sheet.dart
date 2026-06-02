import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:wafer/core/enum/apply_status.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/features/offers/data/models/charity_need_model.dart';
import 'package:wafer/features/offers/data/repo/charity_needs_repo.dart';
import 'package:wafer/features/offers/presentation/manger/charity_need_details_cubit/charity_need_details_cubit.dart';
import 'package:wafer/features/offers/presentation/manger/charity_needs_cubit/charity_needs_state.dart';

class CharityNeedDetailsBottomSheet extends StatelessWidget {
  final String charityNeedId;

  const CharityNeedDetailsBottomSheet({super.key, required this.charityNeedId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CharityNeedDetailsCubit(CharityNeedsRepo(Dio()))
        ..getDetails(charityNeedId),
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: BlocBuilder<CharityNeedDetailsCubit, CharityNeedDetailsState>(
          builder: (context, state) {
            if (state is CharityNeedDetailsLoading) {
              return const SizedBox(
                height: 300,
                child: ColoredBox(
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator()),
                ),
              );
            }
            if (state is CharityNeedDetailsFailure) {
              return SizedBox(
                height: 300,
                child: ColoredBox(
                  color: Colors.white,
                  child: Center(child: Text(state.error)),
                ),
              );
            }
            if (state is CharityNeedDetailsSuccess) {
              return _Body(
                need: state.need,
                applyStatus: state.applyStatus,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final CharityNeedModel need;
  final ApplyStatus applyStatus;

  const _Body({required this.need, required this.applyStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroImage(imageUrl: need.productImage, priority: need.priority),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    need.productName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.volunteer_activism_outlined,
                          size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        need.charityName,
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          label: 'الكمية المطلوبة',
                          value: '${need.quantity}',
                          unit: _unitLabel(need.unit),
                          icon: Icons.inventory_2_outlined,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _StatCard(
                          label: 'تاريخ الطلب',
                          value: _formatDate(need.createdAt),
                          icon: Icons.calendar_today_outlined,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _InfoGroup(
                    children: [
                      if (need.governorate != null || need.city != null)
                        _InfoTile(
                          icon: Icons.map_outlined,
                          label: 'المحافظة / المدينة',
                          value:
                              '${need.governorate ?? ''} — ${need.city ?? ''}',
                        ),
                      if (need.email != null)
                        _InfoTile(
                          icon: Icons.email_outlined,
                          label: 'البريد الإلكتروني',
                          value: need.email!,
                        ),
                      if (need.phone != null)
                        _InfoTile(
                          icon: Icons.phone_outlined,
                          label: 'التليفون',
                          value: need.phone!,
                        ),
                      if (need.whatsapp != null)
                        _InfoTile(
                          icon: Icons.chat_outlined,
                          label: 'واتساب',
                          value: need.whatsapp!,
                          isLast: true,
                        ),
                    ],
                  ),
                  if (need.description != null) ...[
                    const SizedBox(height: 14),
                    _DescBox(title: 'وصف الاحتياج', text: need.description!),
                  ],
                  if (need.charityDescription != null) ...[
                    const SizedBox(height: 10),
                    _DescBox(title: 'عن الجمعية', text: need.charityDescription!),
                  ],
                  const SizedBox(height: 20),
                  _ApplyButton(
                    charityNeedId: need.charityNeedId,
                    applyStatus: applyStatus,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String raw) {
    try {
      final dt = DateTime.parse(raw);
      return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return raw;
    }
  }

  String _unitLabel(int unit) {
    const units = {
      0: 'ملجم', 1: 'كجم', 2: 'طن',
      3: 'لتر',  4: 'مل',  5: 'كرتونة',
      6: 'قطعة', 7: 'علبة', 8: 'حبة',
    };
    return units[unit] ?? 'وحدة';
  }
}

class _HeroImage extends StatelessWidget {
  final String? imageUrl;
  final int priority;

  const _HeroImage({required this.imageUrl, required this.priority});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 220,
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _Placeholder(),
                )
              : _Placeholder(),
        ),
        Positioned(
          bottom: 0, left: 0, right: 0, height: 70,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.white, Colors.transparent],
              ),
            ),
          ),
        ),
        Positioned(
          top: 10, left: 0, right: 0,
          child: Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
        Positioned(
          top: 24, left: 14,
          child: _PriorityBadge(priority: priority),
        ),
      ],
    );
  }
}

class _Placeholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE1F5EE),
      child: const Center(
        child: Icon(Icons.image_not_supported_outlined,
            size: 52, color: Color(0xFF0F6E56)),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isUrgent ? const Color(0xFFFAEEDA) : const Color(0xFFE1F5EE),
        borderRadius: BorderRadius.circular(8),
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

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 13, color: Colors.grey),
              const SizedBox(width: 4),
              Text(label,
                  style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(
              text: value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              children: unit != null
                  ? [
                      TextSpan(
                        text: ' $unit',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                    ]
                  : [],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoGroup extends StatelessWidget {
  final List<Widget> children;
  const _InfoGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade500),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
                const SizedBox(height: 2),
                Text(value,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DescBox extends StatelessWidget {
  final String title;
  final String text;

  const _DescBox({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(text,
              style: const TextStyle(
                  fontSize: 14, color: Colors.black87, height: 1.6)),
        ],
      ),
    );
  }
}

class _ApplyButton extends StatelessWidget {
  final String charityNeedId;
  final ApplyStatus applyStatus;

  const _ApplyButton({required this.charityNeedId, required this.applyStatus});

  @override
  Widget build(BuildContext context) {
    final isLoading = applyStatus == ApplyStatus.loading;
    final isApplied = applyStatus == ApplyStatus.applied;
    final isAlreadyApplied = applyStatus == ApplyStatus.alreadyApplied;
    final isDone = isApplied || isAlreadyApplied;

    final Color btnColor = isAlreadyApplied
        ? Colors.amber.shade600
        : isApplied
            ? Colors.green.shade600
            : AppColors.primaryText;

    final String btnText = isAlreadyApplied
        ? 'تم التقديم مسبقاً'
        : isApplied
            ? 'تم تقديم التبرع ✓'
            : 'تقديم تبرع';

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isDone || isLoading
            ? null
            : () => context
                .read<CharityNeedDetailsCubit>()
                .applyNeed(charityNeedId),
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          disabledBackgroundColor: btnColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2),
              )
            : Text(
                btnText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}