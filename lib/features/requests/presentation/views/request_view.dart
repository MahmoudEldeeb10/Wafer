import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wafer/core/services/dio_client.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/core/widgets/custom_app_bar.dart';
import 'package:wafer/features/requests/data/services/received_applications_service.dart';
import 'package:wafer/features/requests/presentation/manager/received_applications_cubit/received_applications_cubit.dart';
import 'package:wafer/features/requests/presentation/manager/received_applications_cubit/received_applications_state.dart';

import 'widgets/request_card.dart';

class RequestView extends StatelessWidget {
  const RequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ReceivedApplicationsCubit(ReceivedApplicationsService(DioClient.dio))
            ..fetchApplications(),
      child: const _RequestViewBody(),
    );
  }
}

class _RequestViewBody extends StatelessWidget {
  const _RequestViewBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fourthText,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const CustomAppBar(
                title: 'الطلبات الواردة ',
                firstIcon: Icons.search,
                secondIcon: Icons.notifications_none,
              ),
              const SizedBox(height: 10),
              Expanded(
                child:
                    BlocConsumer<
                      ReceivedApplicationsCubit,
                      ReceivedApplicationsState
                    >(
                      listener: (context, state) {
                        if (state is ApplicationActionSuccess) {
                          final msg = state.isAccepted
                              ? '✅ تم قبول الطلب بنجاح'
                              : '❌ تم رفض الطلب';
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                msg,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontFamily: 'Cairo'),
                              ),
                              backgroundColor: state.isAccepted
                                  ? Colors.green.shade700
                                  : Colors.red.shade600,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        }
                        if (state is ApplicationActionFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                state.message,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontFamily: 'Cairo'),
                              ),
                              backgroundColor: Colors.red.shade600,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is ReceivedApplicationsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is ReceivedApplicationsFailure) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  size: 48,
                                  color: Colors.red,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  state.message,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontFamily: 'Cairo'),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () => context
                                      .read<ReceivedApplicationsCubit>()
                                      .fetchApplications(),
                                  child: const Text('إعادة المحاولة'),
                                ),
                              ],
                            ),
                          );
                        }

                        if (state is ReceivedApplicationsSuccess) {
                          if (state.applications.isEmpty) {
                            return const Center(
                              child: Text(
                                'لا توجد طلبات حالياً',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 16,
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                            padding: const EdgeInsets.only(bottom: 100),
                            itemCount: state.applications.length,
                            itemBuilder: (context, index) {
                              final app = state.applications[index];
                              return RequestCard(
                                application: app,
                                onAccept: () => context
                                    .read<ReceivedApplicationsCubit>()
                                    .acceptApplication(app.needApplicationId),
                                onReject: () => context
                                    .read<ReceivedApplicationsCubit>()
                                    .rejectApplication(app.needApplicationId),
                              );
                            },
                          );
                        }

                        return const SizedBox();
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
