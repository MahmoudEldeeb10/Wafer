import 'package:wafer/features/requests/data/model/received_application_model.dart';

abstract class ReceivedApplicationsState {}

class ReceivedApplicationsInitial extends ReceivedApplicationsState {}

class ReceivedApplicationsLoading extends ReceivedApplicationsState {}

class ReceivedApplicationsSuccess extends ReceivedApplicationsState {
  final List<ReceivedApplicationModel> applications;
  ReceivedApplicationsSuccess(this.applications);
}

class ReceivedApplicationsFailure extends ReceivedApplicationsState {
  final String message;
  ReceivedApplicationsFailure(this.message);
}

class ApplicationActionLoading extends ReceivedApplicationsState {
  final String applicationId;
  ApplicationActionLoading(this.applicationId);
}

class ApplicationActionSuccess extends ReceivedApplicationsState {
  final String applicationId;
  final bool isAccepted;
  ApplicationActionSuccess({
    required this.applicationId,
    required this.isAccepted,
  });
}

class ApplicationActionFailure extends ReceivedApplicationsState {
  final String message;
  ApplicationActionFailure(this.message);
}
