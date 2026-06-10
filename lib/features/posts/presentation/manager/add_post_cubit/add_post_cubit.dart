import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wafer/features/posts/data/service/posts_service.dart';
import 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit({required this.role}) : super(AddPostInitial());

  final int role;
  final PostsService _service = PostsService();

  Future<void> addPost({
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
      await _service.addPost(
        role: role,
        category: category,
        productName: productName,
        quantity: quantity,
        unit: unit,
        priority: priority,
        description: description,
        productImage: productImage,
      );
      emit(AddPostSuccess());
    } on Exception catch (e) {
      emit(AddPostError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
