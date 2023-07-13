import 'package:equatable/equatable.dart';

class PostState extends Equatable {
  final bool loading;
  final bool postLikedSuccess;
  final String error;

  const PostState(
      {this.loading = false, this.postLikedSuccess = false, this.error = ""});

  PostState copyWith({
    bool? loading,
    bool? postLikedSuccess,
    String? error,
  }) {
    return PostState(
        loading: loading ?? this.loading,
        postLikedSuccess: postLikedSuccess ?? this.postLikedSuccess,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [loading, postLikedSuccess, error];
}
