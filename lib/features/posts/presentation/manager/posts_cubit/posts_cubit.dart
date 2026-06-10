import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wafer/features/posts/data/service/posts_service.dart';
import 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit({required this.role}) : super(PostsInitial());

  int role;
  final PostsService _service = PostsService();

  void updateRole(int newRole) {
    role = newRole;
  }

  Future<void> getPosts({int? status}) async {
    emit(PostsLoading());
    try {
      final posts = await _service.getPosts(role: role, status: status);
      emit(PostsSuccess(posts));
    } catch (_) {
      emit(PostsError('حدث خطأ، حاول مجدداً'));
    }
  }

  Future<void> fulfillOffer(String offerId) async {
    try {
      await _service.fulfillOffer(offerId);
      await getPosts();
    } catch (_) {
      emit(PostsError('فشل تحديث الحالة'));
    }
  }
}
