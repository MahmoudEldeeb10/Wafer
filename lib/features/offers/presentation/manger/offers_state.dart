import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wafer/features/offers/data/repo/offers_repo.dart';
import 'package:wafer/features/offers/presentation/manger/offers_cubit.dart';

class OffersCubit extends Cubit<OffersState> {
  final OffersRepo offersRepo;

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
}
