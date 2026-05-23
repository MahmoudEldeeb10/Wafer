import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitial());

  final Dio _dio = Dio();
  static const String _baseUrl = 'https://waffer.runasp.net/api/v1';

  Future<void> createCharityNeed({
    required int category,
    required String productName,
    required double quantity,
    required int unit,
    required int priority,
    required String description,
    File? productImage,
  }) async {
    emit(AddPostLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

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

      await _dio.post(
        '$_baseUrl/charity/charity-needs',
        data: formData,
        options: Options(
          headers: {if (token != null) 'Authorization': 'Bearer $token'},
        ),
      );

      emit(AddPostSuccess());
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'حدث خطأ، حاول مجدداً';
      emit(AddPostError(msg.toString()));
    } catch (_) {
      emit(AddPostError('حدث خطأ، حاول مجدداً'));
    }
  }
}
