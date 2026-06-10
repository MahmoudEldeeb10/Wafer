import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wafer/features/posts/data/models/post_model.dart';

class PostsService {
  final Dio _dio = Dio();
  static const String _baseUrl = 'https://waffer.runasp.net/api/v1';

  Future<Options> _authOptions() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return Options(
      headers: {if (token != null) 'Authorization': 'Bearer $token'},
    );
  }

  List<PostModel> _parseList(dynamic responseData) {
    // يدعم: array مباشرة أو { data: [...] } أو { data: { items: [...] } }
    if (responseData is List)
      return responseData.map((e) => PostModel.fromJson(e)).toList();
    final inner = responseData['data'];
    if (inner is List) return inner.map((e) => PostModel.fromJson(e)).toList();
    if (inner is Map) {
      final items = inner['items'] ?? inner['data'] ?? [];
      return (items as List).map((e) => PostModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<PostModel>> getPosts({int role = 0, int? status}) async {
    final endpoint = role == 0
        ? '$_baseUrl/charity/charity-needs'
        : '$_baseUrl/donor-organization/offer/my-offers';

    final response = await _dio.get(
      endpoint,
      queryParameters: status != null ? {'status': status} : null,
      options: await _authOptions(),
    );

    return _parseList(response.data);
  }

  Future<void> addPost({
    required int role,
    required int category,
    required String productName,
    required double quantity,
    required int unit,
    required int priority,
    required String description,
    File? productImage,
  }) async {
    final endpoint = role == 0
        ? '$_baseUrl/charity/charity-needs'
        : '$_baseUrl/donor-organization/offer';

    final formData = FormData.fromMap({
      'Category': category,
      'ProductName': productName,
      'Quantity': quantity,
      'Unit': unit,
      'Priority': priority,
      'Description': description,
      if (productImage != null)
        'ProductImage': await MultipartFile.fromFile(
          productImage.path,
          filename: productImage.path.split('/').last,
        ),
    });

    await _dio.post(endpoint, data: formData, options: await _authOptions());
  }

  Future<void> applyToNeed(String charityNeedId) async {
    await _dio.post(
      '$_baseUrl/donor-organization/charity-needs/$charityNeedId/apply',
      options: await _authOptions(),
    );
  }

  Future<void> fulfillOffer(String offerId) async {
    await _dio.patch(
      '$_baseUrl/donor-organization/offer/$offerId/fulfill',
      options: await _authOptions(),
    );
  }
}
