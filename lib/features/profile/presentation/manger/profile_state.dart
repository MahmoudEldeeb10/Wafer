import 'package:wafer/features/profile/data/models/profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileModel profile;
  ProfileLoaded(this.profile);
}

class ProfileUpdateSuccess extends ProfileState {}

class ProfilePasswordSuccess extends ProfileState {}

class ProfileImageSuccess extends ProfileState {}

class ProfileVerificationSuccess extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
