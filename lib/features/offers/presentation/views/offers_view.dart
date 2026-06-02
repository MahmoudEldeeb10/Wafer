import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wafer/core/widgets/custom_app_bar.dart';
import 'package:wafer/features/offers/data/repo/offers_repo.dart';
import 'package:wafer/features/offers/presentation/manger/offer_cubit/offers_cubit.dart';
import 'package:wafer/features/offers/presentation/views/widgets/charity_need_card.dart';
import 'package:wafer/features/offers/presentation/views/widgets/offer_card.dart';

import '../../data/repo/charity_needs_repo.dart';
import '../manger/charity_needs_cubit/charity_needs_cubit.dart';
import '../manger/charity_needs_cubit/charity_needs_state.dart';
import '../manger/offer_cubit/offers_state.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  Future<int> _getAccountType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('accountType') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FutureBuilder<int>(
            future: _getAccountType(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final isCharity = snapshot.data == 0;

              return Column(
                children: [
                  CustomAppBar(
                    title: isCharity ? 'العروض' : 'احتياجات الجمعيات',
                    firstIcon: Icons.search,
                    secondIcon: Icons.add,
                  ),
                  Expanded(child: isCharity ? _CharityList() : _DonorList()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// ── Charity (accountType == 0) → Offers ──────────────────────────────────────
class _CharityList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OffersCubit(OffersRepo(Dio()))..getOffers(),
      child: BlocBuilder<OffersCubit, OffersState>(
        builder: (context, state) {
          if (state is OffersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OffersSuccess) {
            return ListView.builder(
              itemCount: state.offers.length,
              itemBuilder: (_, index) => OfferCard(offer: state.offers[index]),
            );
          } else if (state is OffersFailure) {
            return Center(child: Text(state.error));
          }
          return const SizedBox();
        },
      ),
    );
  }
}

// ── Donor (accountType == 1) → Charity Needs ─────────────────────────────────
class _DonorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CharityNeedsCubit(CharityNeedsRepo(Dio()))..getCharityNeeds(),
      child: BlocBuilder<CharityNeedsCubit, CharityNeedsState>(
        builder: (context, state) {
          if (state is CharityNeedsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CharityNeedsSuccess) {
            return ListView.builder(
              itemCount: state.needs.length,
              itemBuilder: (_, index) =>
                  CharityNeedCard(need: state.needs[index]),
            );
          } else if (state is CharityNeedsFailure) {
            return Center(child: Text(state.error));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
