import 'package:wafer/features/offers/data/models/offer_details_model.dart';

abstract class OfferDetailsState {}

class OfferDetailsInitial extends OfferDetailsState {}

// --- Details States ---
class OfferDetailsLoading extends OfferDetailsState {}

class OfferDetailsSuccess extends OfferDetailsState {
  final OfferDetailsModel offer;
  final ApplyStatus applyStatus; // نحتفظ بحالة الـ apply

  OfferDetailsSuccess(this.offer, {this.applyStatus = ApplyStatus.idle});
}

class OfferDetailsFailure extends OfferDetailsState {
  final String error;
  OfferDetailsFailure(this.error);
}

// --- Apply Status (embedded في OfferDetailsSuccess) ---
enum ApplyStatus { idle, loading, applied, alreadyApplied }