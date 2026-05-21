import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wafer/core/utils/styles.dart';
import 'package:wafer/features/requests/data/model/received_application_model.dart';
import 'package:wafer/features/requests/presentation/manager/received_applications_cubit/received_applications_cubit.dart';
import 'package:wafer/features/requests/presentation/manager/received_applications_cubit/received_applications_state.dart';
import 'info_row.dart';

class RequestCard extends StatelessWidget {
  final ReceivedApplicationModel application;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const RequestCard({
    super.key,
    required this.application,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceivedApplicationsCubit, ReceivedApplicationsState>(
      builder: (context, state) {
        final isLoading =
            state is ApplicationActionLoading &&
            state.applicationId == application.needApplicationId;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header Row — صورة المنتج + اسم المؤسسة
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      application.productImage,
                      width: 52,
                      height: 52,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          application.donorOrganizationName,
                          style: Styles.textStyle18,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          application.productName,
                          style: Styles.textStyle14.copyWith(
                            color: Colors.grey.shade600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),

              /// Details
              InfoRow(
                icon: Icons.inventory_2_outlined,
                label: 'الكمية',
                value: '${application.quantity.toInt()} وحدة',
              ),
              const SizedBox(height: 6),
              InfoRow(
                icon: Icons.phone_outlined,
                label: 'التواصل',
                value: application.phone,
              ),
              const SizedBox(height: 6),
              InfoRow(
                icon: Icons.location_on_outlined,
                label: 'الموقع',
                value: '${application.city}، ${application.governorate}',
              ),
              const SizedBox(height: 6),
              InfoRow(
                icon: Icons.description_outlined,
                label: 'التفاصيل',
                value: application.needDescription,
                maxLines: 2,
              ),

              const SizedBox(height: 14),

              /// Action Buttons
              if (application.status == 0) ...[
                isLoading
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade700,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                              ),
                              onPressed: onAccept,
                              icon: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 18,
                              ),
                              label: const Text(
                                'قبول',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade600,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                              ),
                              onPressed: onReject,
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 18,
                              ),
                              label: const Text(
                                'رفض',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ] else if (application.status == 1) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.green.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onPressed: null,
                    icon: const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: const Text(
                      'تم القبول',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ),
              ] else if (application.status == 2) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.red.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onPressed: null,
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: const Text(
                      'تم الرفض',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
