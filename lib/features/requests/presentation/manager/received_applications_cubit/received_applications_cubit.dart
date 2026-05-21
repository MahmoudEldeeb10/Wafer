import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wafer/features/requests/data/model/received_application_model.dart';
import 'package:wafer/features/requests/data/services/received_applications_service.dart';
import 'received_applications_state.dart';

class ReceivedApplicationsCubit extends Cubit<ReceivedApplicationsState> {
  final ReceivedApplicationsService _service;

  List<ReceivedApplicationModel> _applications = [];

  ReceivedApplicationsCubit(this._service)
    : super(ReceivedApplicationsInitial());

  Future<void> fetchApplications() async {
    emit(ReceivedApplicationsLoading());
    try {
      _applications = await _service.getReceivedApplications();
      emit(ReceivedApplicationsSuccess(List.from(_applications)));
    } catch (e) {
      emit(ReceivedApplicationsFailure(e.toString()));
    }
  }

  Future<void> acceptApplication(String id) async {
    emit(ApplicationActionLoading(id));
    try {
      await _service.acceptApplication(id);
      _updateStatus(id, 1);
      emit(ApplicationActionSuccess(applicationId: id, isAccepted: true));
      emit(ReceivedApplicationsSuccess(List.from(_applications)));
    } catch (e) {
      emit(ApplicationActionFailure(e.toString()));
      emit(ReceivedApplicationsSuccess(List.from(_applications)));
    }
  }

  Future<void> rejectApplication(String id) async {
    emit(ApplicationActionLoading(id));
    try {
      await _service.rejectApplication(id);
      _updateStatus(id, 2);
      emit(ApplicationActionSuccess(applicationId: id, isAccepted: false));
      emit(ReceivedApplicationsSuccess(List.from(_applications)));
    } catch (e) {
      emit(ApplicationActionFailure(e.toString()));
      emit(ReceivedApplicationsSuccess(List.from(_applications)));
    }
  }

  void _updateStatus(String id, int newStatus) {
    _applications = _applications.map((app) {
      if (app.needApplicationId == id) {
        return app.copyWith(status: newStatus);
      }
      return app;
    }).toList();
  }
}
