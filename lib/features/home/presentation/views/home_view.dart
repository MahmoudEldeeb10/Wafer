import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:wafer/core/utils/styles.dart';
import 'package:wafer/features/home/presentation/views/widgets/custom_home_card.dart';
import 'package:wafer/features/offers/data/repo/offers_repo.dart';
import 'package:wafer/features/offers/presentation/manger/offers_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OffersCubit(OffersRepo(Dio()))..getOffers(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 65,
                          height: 65,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 65,
                              height: 65,
                              decoration: const BoxDecoration(
                                color: Color(0xFF6C2CB9),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.volunteer_activism,
                                color: Colors.white,
                                size: 30,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'مرحباً,',
                            style: Styles.textStyle30.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'جمعية مصر الخير',
                            style: Styles.textStyle30.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // تصفح المنشورات
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'تصفح المنشورات',
                    style: Styles.textStyle30.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // الكروت
                BlocBuilder<OffersCubit, OffersState>(
                  builder: (context, state) {
                    if (state is OffersLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF6C2CB9),
                        ),
                      );
                    } else if (state is OffersSuccess) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.offers.length,
                        itemBuilder: (context, index) {
                          final offer = state.offers[index];
                          return CustomHomeCard(
                            title: offer.donorOrganizationName,
                            productName: offer.productName,
                            quantity: offer.quantity,
                            imageUrl: offer.productImage,
                          );
                        },
                      );
                    } else if (state is OffersFailure) {
                      return Center(
                        child: Text(
                          'حدث خطأ: ${state.error}',
                          style: Styles.textStyle14,
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
