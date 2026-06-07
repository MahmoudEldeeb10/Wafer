import 'package:dio/dio.dart';
import 'package:wafer/features/requests/data/model/received_application_model.dart';

class ReceivedApplicationsService {
  final Dio _dio;
  final String _baseEndpoint;
  final String _idKey;

  // / charity    → baseEndpoint: '/api/v1/charity/applications'
  ///              idKey: 'needApplicationId'
  /// donor      → baseEndpoint: '/api/v1/donor-organization/offer-applications'
  ///              idKey: 'offerApplicationId'
  ReceivedApplicationsService({
    required Dio dio,
    required String baseEndpoint,
    required String idKey,
  }) : _dio = dio,
       _baseEndpoint = baseEndpoint,
       _idKey = idKey;

  Future<List<ReceivedApplicationModel>> getReceivedApplications() async {
    final response = await _dio.get('$_baseEndpoint/received');
    final List data = response.data['data'] ?? response.data;
    return data
        .map((e) => ReceivedApplicationModel.fromJson(e, idKey: _idKey))
        .toList();
  }

  Future<void> acceptApplication(String id) async {
    try {
      await _dio.patch('$_baseEndpoint/$id/accept');
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ?? 'حدث خطأ، حاول مرة أخرى';
      throw Exception(message);
    }
  }

  Future<void> rejectApplication(String id) async {
    try {
      await _dio.patch('$_baseEndpoint/$id/reject');
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ?? 'حدث خطأ، حاول مرة أخرى';
      throw Exception(message);
    }
  }
}

// import 'package:dio/dio.dart';
// import 'package:wafer/features/requests/data/model/received_application_model.dart';

// class ReceivedApplicationsService {
//   final Dio _dio;

//   ReceivedApplicationsService(this._dio);

//   Future<List<ReceivedApplicationModel>> getReceivedApplications() async {
//     final response = await _dio.get('/api/v1/charity/applications/received');
//     final List data = response.data['data'] ?? response.data;
//     return data.map((e) => ReceivedApplicationModel.fromJson(e)).toList();
//   }

//   Future<void> acceptApplication(String needApplicationId) async {
//     try {
//       await _dio.patch(
//         '/api/v1/charity/applications/$needApplicationId/accept',
//       );
//     } on DioException catch (e) {
//       final message = e.response?.data?['message'] ?? 'حدث خطأ، حاول مرة أخرى';
//       throw Exception(message);
//     }
//   }

//   Future<void> rejectApplication(String needApplicationId) async {
//     try {
//       await _dio.patch(
//         '/api/v1/charity/applications/$needApplicationId/reject',
//       );
//     } on DioException catch (e) {
//       final message = e.response?.data?['message'] ?? 'حدث خطأ، حاول مرة أخرى';
//       throw Exception(message);
//     }
//   }
// }
