import 'package:dio/dio.dart';

import '../models/profile_model.dart';
import '../services/profile_service.dart';

class ProfileRepo {
  final ProfileService _service = ProfileService();

  Future<ProfileModel> getProfile() async {
    try {
      final res = await _service.getProfile();
      return ProfileModel.fromJson(res['data']);
    } catch (e) {
      throw Exception(_parseError(e));
    }
  }

  Future<void> updateProfile(ProfileModel model) async {
    try {
      await _service.updateProfile(model.toJson());
    } catch (e) {
      throw Exception(_parseError(e));
    }
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _service.updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    } catch (e) {
      throw Exception(_parseError(e));
    }
  }

  Future<void> updateImage(String imagePath) async {
    try {
      await _service.updateImage(imagePath);
    } catch (e) {
      throw Exception(_parseError(e));
    }
  }

  Future<void> submitVerification() async {
    try {
      await _service.submitVerification();
    } catch (e) {
      throw Exception(_parseError(e));
    }
  }

  Future<void> cancelVerification() async {
    try {
      await _service.cancelVerification();
    } catch (e) {
      throw Exception(_parseError(e));
    }
  }

  String _parseError(dynamic e) {
    if (e is DioException) {
      return e.response?.data['message'] ?? e.message ?? 'حدث خطأ';
    }
    return e.toString().replaceAll('Exception: ', '');
  }
}
