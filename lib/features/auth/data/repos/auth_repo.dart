import 'package:dio/dio.dart';
import 'package:wafer/core/services/dio_client.dart';
import 'package:wafer/core/utils/api_constants.dart';
import '../models/auth_model.dart';

class AuthRepo {
  final Dio _dio = DioClient.dio;

  Future<AuthResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: request.toJson(),
      );
      print('Response data: ${response.data}');
      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;
      final errors = data?['error']?['details']?['errors'] as List?;
      if (errors != null && errors.isNotEmpty) {
        final messages = errors.map((e) => e['message']).join('\n');
        throw Exception(messages);
      }
      final message = data?['message'] ?? 'حدث خطأ، حاول مرة أخرى';
      throw Exception(message);
    }
  }

  Future<AuthResponseModel> register(RegisterRequestModel request) async {
    try {
      final response = await _dio.post(
        ApiConstants.register,
        data: request.toJson(),
      );
      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;
      final errors = data?['error']?['details']?['errors'] as List?;
      if (errors != null && errors.isNotEmpty) {
        final messages = errors.map((e) => e['message']).join('\n');
        throw Exception(messages);
      }
      final message = data?['message'] ?? 'حدث خطأ، حاول مرة أخرى';
      throw Exception(message);
    }
  }
}