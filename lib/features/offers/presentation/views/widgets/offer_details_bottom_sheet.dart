import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/features/offers/data/models/offer_details_model.dart';
import 'package:wafer/features/offers/data/repo/offer_details_repo.dart';
import 'package:wafer/features/offers/presentation/manger/offer_details_cubit/offer_details_cubit.dart';
import 'package:wafer/features/offers/presentation/manger/offer_details_cubit/offer_details_state.dart';

class OfferDetailsBottomSheet extends StatelessWidget {
  final String offerId;

  const OfferDetailsBottomSheet({super.key, required this.offerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          OfferDetailsCubit(OfferDetailsRepo(Dio()))..getOfferDetails(offerId),
      child: const _OfferDetailsContent(),
    );
  }
}

class _OfferDetailsContent extends StatelessWidget {
  const _OfferDetailsContent();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: BlocBuilder<OfferDetailsCubit, OfferDetailsState>(
          builder: (context, state) {
            if (state is OfferDetailsLoading) {
              return const SizedBox(
                height: 300,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (state is OfferDetailsFailure) {
              return SizedBox(
                height: 300,
                child: Center(child: Text(state.error)),
              );
            }
            if (state is OfferDetailsSuccess) {
              return _OfferDetailsBody(
                offer: state.offer,
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

class _OfferDetailsBody extends StatelessWidget {
  final OfferDetailsModel offer;
  final ApplyStatus applyStatus;

  const _OfferDetailsBody({required this.offer, required this.applyStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hero Image ──────────────────────────────────────
            _HeroImage(imageUrl: offer.productImage, status: offer.status),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── اسم المنتج + المنظمة ──────────────────────
                  Text(
                    offer.productName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.business_outlined,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        offer.donorOrganizationName,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ── بطاقتا الكمية وتاريخ الانتهاء ────────────
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          label: 'الكمية',
                          value: '${offer.quantity}',
                          unit: 'وحدة',
                          icon: Icons.inventory_2_outlined,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _StatCard(
                          label: 'تاريخ الانتهاء',
                          value: _formatDate(offer.expiryDate),
                          icon: Icons.calendar_today_outlined,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // ── تفاصيل الموقع والتواصل ────────────────────
                  _InfoGroup(
                    children: [
                      if (offer.governorate != null || offer.city != null)
                        _InfoTile(
                          icon: Icons.map_outlined,
                          label: 'المحافظة / المدينة',
                          value:
                              '${offer.governorate ?? ''}${offer.city != null ? ' — ${offer.city}' : ''}',
                        ),
                      if (offer.address != null)
                        _InfoTile(
                          icon: Icons.location_on_outlined,
                          label: 'العنوان',
                          value: offer.address!,
                        ),
                      if (offer.phone != null)
                        _InfoTile(
                          icon: Icons.phone_outlined,
                          label: 'التليفون',
                          value: offer.phone!,
                          isLast: true,
                        ),
                    ],
                  ),

                  // ── الوصف ─────────────────────────────────────
                  if (offer.description != null) ...[
                    const SizedBox(height: 14),
                    Container(
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
                          const Text(
                            'الوصف',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            offer.description!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 20),

                  // ── زرار التقديم ──────────────────────────────
                  _ApplyButton(
                    offerId: offer.offerId,
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
}

// ── Hero Image ────────────────────────────────────────────────────────────────
class _HeroImage extends StatelessWidget {
  final String? imageUrl;
  final int status;

  const _HeroImage({required this.imageUrl, required this.status});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Handle bar
        Positioned(
          top: 10,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),

        // الصورة
        SizedBox(
          width: double.infinity,
          height: 220,
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _PlaceholderImage(),
                )
              : _PlaceholderImage(),
        ),

        // gradient fade للأسفل
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 70,
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

        // status badge
        Positioned(top: 24, left: 14, child: _StatusBadge(status: status)),
      ],
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE1F5EE),
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 52,
          color: Color(0xFF0F6E56),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final int status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final isActive = status == 1;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFE1F5EE) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isActive ? 'متاح' : 'غير متاح',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isActive ? const Color(0xFF0F6E56) : Colors.grey.shade600,
        ),
      ),
    );
  }
}

// ── Stat Card ─────────────────────────────────────────────────────────────────
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
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
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

// ── Info Group ────────────────────────────────────────────────────────────────
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
                Text(
                  label,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Apply Button ──────────────────────────────────────────────────────────────
class _ApplyButton extends StatelessWidget {
  final String offerId;
  final ApplyStatus applyStatus;

  const _ApplyButton({required this.offerId, required this.applyStatus});

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
        ? 'تم تقديم الطلب ✓'
        : 'الحصول على العرض';

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isDone || isLoading
            ? null
            : () => context.read<OfferDetailsCubit>().applyOffer(offerId),
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
                  color: Colors.white,
                  strokeWidth: 2,
                ),
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
