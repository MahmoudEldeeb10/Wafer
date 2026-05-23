import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wafer/features/posts/data/service/posts_service.dart';
import 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());

  final PostsService _service = PostsService();

  // نحتفظ بالـ posts عشان نرجع لها بعد fulfill/apply
  List _currentPosts = [];

  Future<void> getPosts({int? status}) async {
    emit(PostsLoading());
    try {
      final posts = await _service.getCharityNeeds(status: status);
      _currentPosts = posts;
      emit(PostsSuccess(posts));
    } catch (e) {
      emit(PostsError('حدث خطأ، حاول مجدداً'));
    }
  }

  Future<void> fulfillPost(String postId) async {
    try {
      await _service.fulfillPost(postId);
      emit(PostsFulfillSuccess());
      await getPosts(); // refresh
    } catch (e) {
      emit(PostsError('فشل تحديث الحالة'));
    }
  }

  Future<void> applyToPost(String postId) async {
    try {
      await _service.applyToPost(postId);
      emit(PostsApplySuccess());
      await getPosts(); // refresh
    } catch (e) {
      emit(PostsError('فشل التقدم للمنشور'));
    }
  }
}
