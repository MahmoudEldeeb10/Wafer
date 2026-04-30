import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:wafer/core/widgets/custom_app_bar.dart';
import 'package:wafer/features/offers/data/repo/offers_repo.dart';
import 'package:wafer/features/offers/presentation/manger/offers_cubit.dart';
import 'package:wafer/features/offers/presentation/views/widgets/offer_card.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OffersCubit(OffersRepo(Dio()))..getOffers(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                CustomAppBar(
                  title: 'العروض',
                  firstIcon: Icons.search,
                  secondIcon: Icons.add,
                ), // Add your custom widget here
                Expanded(
                  child: BlocBuilder<OffersCubit, OffersState>(
                    builder: (context, state) {
                      if (state is OffersLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is OffersSuccess) {
                        return ListView.builder(
                          itemCount: state.offers.length,
                          itemBuilder: (context, index) {
                            final offer = state.offers[index];
                            return OfferCard(offer: offer);
                          },
                        );
                      } else if (state is OffersFailure) {
                        return Center(child: Text(state.error));
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
