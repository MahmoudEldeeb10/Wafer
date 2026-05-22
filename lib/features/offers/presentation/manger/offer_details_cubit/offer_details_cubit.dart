import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wafer/features/offers/data/repo/offer_details_repo.dart';
import 'offer_details_state.dart';

class OfferDetailsCubit extends Cubit<OfferDetailsState> {
  final OfferDetailsRepo repo;

  OfferDetailsCubit(this.repo) : super(OfferDetailsInitial());

  Future<void> getOfferDetails(String offerId) async {
    emit(OfferDetailsLoading());
    try {
      final offer = await repo.getOfferDetails(offerId);
      emit(OfferDetailsSuccess(offer));
    } catch (e) {
      emit(OfferDetailsFailure(e.toString()));
    }
  }

  Future<void> applyOffer(String offerId) async {
    final currentState = state;
    if (currentState is! OfferDetailsSuccess) return;

    // نحدّث الـ state بـ loading على الزرار بس (مش loading كامل)
    emit(
      OfferDetailsSuccess(currentState.offer, applyStatus: ApplyStatus.loading),
    );

    try {
      final statusCode = await repo.applyOffer(offerId);

      if (statusCode == 201) {
        emit(
          OfferDetailsSuccess(
            currentState.offer,
            applyStatus: ApplyStatus.applied,
          ),
        );
      } else if (statusCode == 409) {
        emit(
          OfferDetailsSuccess(
            currentState.offer,
            applyStatus: ApplyStatus.alreadyApplied,
          ),
        );
      } else {
        emit(
          OfferDetailsSuccess(
            currentState.offer,
            applyStatus: ApplyStatus.idle,
          ),
        );
      }
    } catch (e) {
      emit(
        OfferDetailsSuccess(currentState.offer, applyStatus: ApplyStatus.idle),
      );
    }
  }
}
