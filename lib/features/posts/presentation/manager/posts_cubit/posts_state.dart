import 'package:wafer/features/posts/data/models/post_model.dart';

abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsSuccess extends PostsState {
  final List<PostModel> posts;
  PostsSuccess(this.posts);
}

class PostsError extends PostsState {
  final String message;
  PostsError(this.message);
}

class PostsApplySuccess extends PostsState {}

class PostsFulfillSuccess extends PostsState {}
