import 'package:wafer/features/offers/data/models/offer_model.dart';

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
