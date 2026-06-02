import 'package:wafer/core/enum/apply_status.dart';
import 'package:wafer/features/offers/data/models/charity_need_model.dart';

abstract class CharityNeedsState {}

class CharityNeedsInitial extends CharityNeedsState {}

class CharityNeedsLoading extends CharityNeedsState {}

class CharityNeedsSuccess extends CharityNeedsState {
  final List<CharityNeedModel> needs;
  CharityNeedsSuccess(this.needs);
}

class CharityNeedsFailure extends CharityNeedsState {
  final String error;
  CharityNeedsFailure(this.error);
}

abstract class CharityNeedDetailsState {}

class CharityNeedDetailsInitial extends CharityNeedDetailsState {}

class CharityNeedDetailsLoading extends CharityNeedDetailsState {}

class CharityNeedDetailsSuccess extends CharityNeedDetailsState {
  final CharityNeedModel need;
  final ApplyStatus applyStatus;

  CharityNeedDetailsSuccess(this.need, {this.applyStatus = ApplyStatus.idle});
}

class CharityNeedDetailsFailure extends CharityNeedDetailsState {
  final String error;
  CharityNeedDetailsFailure(this.error);
}
