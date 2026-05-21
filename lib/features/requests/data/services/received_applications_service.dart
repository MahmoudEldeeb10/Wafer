import 'package:dio/dio.dart';
import 'package:wafer/features/requests/data/model/received_application_model.dart';

class ReceivedApplicationsService {
  final Dio _dio;

  ReceivedApplicationsService(this._dio);

  Future<List<ReceivedApplicationModel>> getReceivedApplications() async {
    final response = await _dio.get('/api/v1/charity/applications/received');
    final List data = response.data['data'] ?? response.data;
    return data.map((e) => ReceivedApplicationModel.fromJson(e)).toList();
  }

  Future<void> acceptApplication(String needApplicationId) async {
    try {
      await _dio.patch(
        '/api/v1/charity/applications/$needApplicationId/accept',
      );
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ?? 'حدث خطأ، حاول مرة أخرى';
      throw Exception(message);
    }
  }

  Future<void> rejectApplication(String needApplicationId) async {
    try {
      await _dio.patch(
        '/api/v1/charity/applications/$needApplicationId/reject',
      );
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ?? 'حدث خطأ، حاول مرة أخرى';
      throw Exception(message);
    }
  }
}
