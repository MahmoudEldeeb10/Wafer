import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  final Dio _dio;

  ProfileService()
    : _dio = Dio(BaseOptions(baseUrl: 'https://waffer.runasp.net'))
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              final prefs = await SharedPreferences.getInstance();
              final token = prefs.getString('token');
              if (token != null) {
                options.headers['Authorization'] = 'Bearer $token';
              }
              handler.next(options);
            },
          ),
        );

  Future<Map<String, dynamic>> getProfile() async {
    final res = await _dio.get('/api/v1/profile');
    return res.data;
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    final res = await _dio.put('/api/v1/profile', data: data);
    return res.data;
  }

  Future<Map<String, dynamic>> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final res = await _dio.put(
      '/api/v1/profile/password',
      data: {'current_password': currentPassword, 'new_password': newPassword},
    );
    return res.data;
  }

  Future<Map<String, dynamic>> updateImage(String imagePath) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imagePath),
    });
    final res = await _dio.post('/api/v1/profile/image', data: formData);
    return res.data;
  }

  Future<Map<String, dynamic>> submitVerification() async {
    final res = await _dio.post('/api/v1/profile/submit-verification');
    return res.data;
  }

  Future<Map<String, dynamic>> cancelVerification() async {
    final res = await _dio.post('/api/v1/profile/cancel-verification');
    return res.data;
  }
}
