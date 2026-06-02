import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wafer/core/enum/apply_status.dart';
import 'package:wafer/features/offers/data/repo/charity_needs_repo.dart';
import 'package:wafer/features/offers/presentation/manger/charity_needs_cubit/charity_needs_state.dart';


class CharityNeedDetailsCubit extends Cubit<CharityNeedDetailsState> {
  final CharityNeedsRepo repo;

  CharityNeedDetailsCubit(this.repo) : super(CharityNeedDetailsInitial());

  Future<void> getDetails(String charityNeedId) async {
    emit(CharityNeedDetailsLoading());
    try {
      final need = await repo.getCharityNeedDetails(charityNeedId);
      emit(CharityNeedDetailsSuccess(need));
    } catch (e) {
      emit(CharityNeedDetailsFailure(e.toString()));
    }
  }

  Future<void> applyNeed(String charityNeedId) async {
    final current = state;
    if (current is! CharityNeedDetailsSuccess) return;

    emit(
      CharityNeedDetailsSuccess(current.need, applyStatus: ApplyStatus.loading),
    );

    try {
      final statusCode = await repo.applyCharityNeed(charityNeedId);

      if (statusCode == 201) {
        emit(
          CharityNeedDetailsSuccess(
            current.need,
            applyStatus: ApplyStatus.applied,
          ),
        );
      } else if (statusCode == 409) {
        emit(
          CharityNeedDetailsSuccess(
            current.need,
            applyStatus: ApplyStatus.alreadyApplied,
          ),
        );
      } else {
        emit(
          CharityNeedDetailsSuccess(
            current.need,
            applyStatus: ApplyStatus.idle,
          ),
        );
      }
    } catch (e) {
      emit(
        CharityNeedDetailsSuccess(current.need, applyStatus: ApplyStatus.idle),
      );
    }
  }
}
