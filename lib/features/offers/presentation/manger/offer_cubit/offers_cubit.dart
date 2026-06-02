import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wafer/core/enum/apply_status.dart';
import 'package:wafer/features/offers/data/repo/offers_repo.dart';
import 'package:wafer/features/offers/presentation/manger/offer_cubit/offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  final OffersRepo offersRepo;

  // ✅ بنحفظ status كل offer هنا
  final Map<String, ApplyStatus> applyStatuses = {};

  OffersCubit(this.offersRepo) : super(OffersInitial());

  Future<void> getOffers() async {
    emit(OffersLoading());
    try {
      final offers = await offersRepo.getOffers();
      emit(OffersSuccess(offers));
    } catch (e) {
      emit(OffersFailure(e.toString()));
    }
  }

  void updateApplyStatus(String offerId, ApplyStatus status) {
    applyStatuses[offerId] = status;
    // نعمل emit لنفس الـ state عشان الـ UI يتحدث
    if (state is OffersSuccess) {
      emit(OffersSuccess((state as OffersSuccess).offers));
    }
  }
}
