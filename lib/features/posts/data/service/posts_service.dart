import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wafer/features/posts/data/models/post_model.dart';

class PostsService {
  final Dio _dio = Dio();

  static const String _baseUrl = 'https://waffer.runasp.net/api/v1';

  Future<List<PostModel>> getCharityNeeds({int? status}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await _dio.get(
      '$_baseUrl/charity/charity-needs',
      queryParameters: status != null ? {'status': status} : null,
      options: Options(
        headers: {if (token != null) 'Authorization': 'Bearer $token'},
      ),
    );

    final List data = response.data is List
        ? response.data
        : response.data['data'] ?? response.data['items'] ?? [];

    return data.map((e) => PostModel.fromJson(e)).toList();
  }

  Future<void> fulfillPost(String postId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    await _dio.patch(
      '$_baseUrl/charity/charity-needs/$postId/fulfill',
      options: Options(
        headers: {if (token != null) 'Authorization': 'Bearer $token'},
      ),
    );
  }

  Future<void> applyToPost(String postId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    await _dio.post(
      '$_baseUrl/donor/apply/$postId',
      options: Options(
        headers: {if (token != null) 'Authorization': 'Bearer $token'},
      ),
    );
  }
}
