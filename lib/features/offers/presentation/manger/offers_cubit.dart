import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wafer/features/offers/data/repo/offers_repo.dart';
import 'package:wafer/features/offers/data/models/offer_model.dart';
part 'offers_state.dart';

abstract class OffersState {}

class OffersInitial extends OffersState {}

class OffersLoading extends OffersState {}

class OffersSuccess extends OffersState {
  final List<OfferModel> offers;

  OffersSuccess(this.offers);
}

class OffersFailure extends OffersState {
  final String error;

  OffersFailure(this.error);
}
