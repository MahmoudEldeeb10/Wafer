import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:wafer/core/utils/app_colors.dart';
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
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: BlocBuilder<OfferDetailsCubit, OfferDetailsState>(
          builder: (context, state) {
            if (state is OfferDetailsLoading) {
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (state is OfferDetailsFailure) {
              return SizedBox(
                height: 200,
                child: Center(child: Text(state.error)),
              );
            }

            if (state is OfferDetailsSuccess) {
              final offer = state.offer;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    // صورة + اسم المنظمة
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.grey.shade100,
                          backgroundImage: offer.productImage != null
                              ? NetworkImage(offer.productImage!)
                              : null,
                          child: offer.productImage == null
                              ? const Icon(Icons.inventory_2_outlined)
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                offer.donorOrganizationName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (offer.governorate != null)
                                Text(
                                  offer.governorate!,
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 13,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const Divider(height: 28),

                    // تفاصيل
                    _InfoRow(
                      icon: Icons.inventory_outlined,
                      label: 'المنتج',
                      value: offer.productName,
                    ),
                    _InfoRow(
                      icon: Icons.numbers_outlined,
                      label: 'الكمية',
                      value: '${offer.quantity}',
                    ),
                    _InfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'تاريخ الانتهاء',
                      value: offer.expiryDate,
                    ),
                    if (offer.city != null)
                      _InfoRow(
                        icon: Icons.location_city_outlined,
                        label: 'المدينة',
                        value: offer.city!,
                      ),
                    if (offer.address != null)
                      _InfoRow(
                        icon: Icons.location_on_outlined,
                        label: 'العنوان',
                        value: offer.address!,
                      ),
                    if (offer.phone != null)
                      _InfoRow(
                        icon: Icons.phone_outlined,
                        label: 'التليفون',
                        value: offer.phone!,
                      ),
                    if (offer.description != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'الوصف',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(offer.description!),
                    ],

                    const SizedBox(height: 20),

                    // زرار التقديم
                    _ApplyButton(
                      offerId: offer.offerId,
                      applyStatus: state.applyStatus,
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primaryText),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _ApplyButton extends StatelessWidget {
  final String offerId;
  final ApplyStatus applyStatus;

  const _ApplyButton({required this.offerId, required this.applyStatus});

  @override
  Widget build(BuildContext context) {
    // تحديد شكل الزرار حسب الحالة
    final isLoading = applyStatus == ApplyStatus.loading;
    final isApplied = applyStatus == ApplyStatus.applied;
    final isAlreadyApplied = applyStatus == ApplyStatus.alreadyApplied;
    final isDone = isApplied || isAlreadyApplied;

    final Color btnColor = isAlreadyApplied
        ? Colors.amber
        : isApplied
        ? Colors.green
        : AppColors.primaryText;

    final String btnText = isAlreadyApplied
        ? 'تم التقديم مسبقاً'
        : isApplied
        ? 'تم تقديم الطلب'
        : 'الحصول على العرض';

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isDone || isLoading
            ? null
            : () => context.read<OfferDetailsCubit>().applyOffer(offerId),
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          disabledBackgroundColor: btnColor, // نحافظ على اللون حتى لو disabled
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
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
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
      ),
    );
  }
}
