import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repo/charity_needs_repo.dart';
import 'charity_needs_state.dart';

class CharityNeedsCubit extends Cubit<CharityNeedsState> {
  final CharityNeedsRepo repo;

  CharityNeedsCubit(this.repo) : super(CharityNeedsInitial());

  Future<void> getCharityNeeds() async {
    emit(CharityNeedsLoading());
    try {
      final needs = await repo.getCharityNeeds();
      emit(CharityNeedsSuccess(needs));
    } catch (e) {
      emit(CharityNeedsFailure(e.toString()));
    }
  }
}
