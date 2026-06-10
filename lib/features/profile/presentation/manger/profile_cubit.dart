import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wafer/features/profile/data/models/profile_model.dart';
import 'package:wafer/features/profile/data/repos/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _repo = ProfileRepo();

  ProfileCubit() : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await _repo.getProfile();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> updateProfile(ProfileModel model) async {
    emit(ProfileLoading());
    try {
      await _repo.updateProfile(model);
      emit(ProfileUpdateSuccess());
    } catch (e) {
      emit(ProfileError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(ProfileLoading());
    try {
      await _repo.updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      emit(ProfilePasswordSuccess());
    } catch (e) {
      emit(ProfileError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> updateImage(String imagePath) async {
    emit(ProfileLoading());
    try {
      await _repo.updateImage(imagePath);
      emit(ProfileImageSuccess());
    } catch (e) {
      emit(ProfileError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> submitVerification() async {
    emit(ProfileLoading());
    try {
      await _repo.submitVerification();
      emit(ProfileVerificationSuccess());
    } catch (e) {
      emit(ProfileError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> cancelVerification() async {
    emit(ProfileLoading());
    try {
      await _repo.cancelVerification();
      emit(ProfileVerificationSuccess());
    } catch (e) {
      emit(ProfileError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
