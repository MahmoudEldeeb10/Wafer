import 'package:wafer/core/enum/apply_status.dart';
import 'package:wafer/features/offers/data/models/offer_details_model.dart';
abstract class OfferDetailsState {}

class OfferDetailsInitial extends OfferDetailsState {}

class OfferDetailsLoading extends OfferDetailsState {}

class OfferDetailsSuccess extends OfferDetailsState {
  final OfferDetailsModel offer;
  final ApplyStatus applyStatus;

  OfferDetailsSuccess(this.offer, {this.applyStatus = ApplyStatus.idle});
}

class OfferDetailsFailure extends OfferDetailsState {
  final String error;
  OfferDetailsFailure(this.error);
}