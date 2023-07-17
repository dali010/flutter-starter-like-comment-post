import 'package:equatable/equatable.dart';

import '../../data/models/comment_model.dart';

class PostState extends Equatable {
  final bool loading;
  final bool postLikedSuccess;
  final String error;
  final List<CommentModel> comments;
  final bool loadingNextPage;
  final bool hasReachedTheEnd;
  final int currentPage;

  const PostState(
      {this.loading = false,
      this.postLikedSuccess = false,
      this.error = "",
      this.comments = const [],
      this.loadingNextPage = false,
      this.hasReachedTheEnd = false,
      this.currentPage = 0});

  PostState copyWith(
      {bool? loading,
      bool? postLikedSuccess,
      String? error,
      List<CommentModel>? comments,
      bool? loadingNextPage,
      bool? hasReachedTheEnd,
      int? currentPage}) {
    return PostState(
        loading: loading ?? this.loading,
        postLikedSuccess: postLikedSuccess ?? this.postLikedSuccess,
        error: error ?? this.error,
        comments: comments ?? this.comments,
        loadingNextPage: loadingNextPage ?? this.loadingNextPage,
        hasReachedTheEnd: hasReachedTheEnd ?? this.hasReachedTheEnd,
        currentPage: currentPage ?? this.currentPage);
  }

  @override
  List<Object?> get props => [
        loading,
        postLikedSuccess,
        error,
        comments,
        loadingNextPage,
        hasReachedTheEnd,
        currentPage
      ];
}
