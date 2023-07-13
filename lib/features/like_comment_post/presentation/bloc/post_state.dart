import 'package:equatable/equatable.dart';

import '../../data/models/comment_model.dart';

class PostState extends Equatable {
  final bool loading;
  final bool postLikedSuccess;
  final String error;
  final List<CommentModel> comments;

  const PostState(
      {
        this.loading = false,
        this.postLikedSuccess = false,
        this.error = "",
        this.comments = const []
      });

  PostState copyWith({
    bool? loading,
    bool? postLikedSuccess,
    String? error,
    List<CommentModel>? comments
  }) {
    return PostState(
        loading: loading ?? this.loading,
        postLikedSuccess: postLikedSuccess ?? this.postLikedSuccess,
        error: error ?? this.error,
      comments: comments ?? this.comments
    );
  }

  @override
  List<Object?> get props => [loading, postLikedSuccess, error, comments];
}
