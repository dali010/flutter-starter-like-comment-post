import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/domain/use_cases/comment_use_case.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/domain/use_cases/getAllCommentUseCase.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/domain/use_cases/like_post_use_case.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/presentation/bloc/post_event.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/presentation/bloc/post_state.dart';

import '../../../../core/utils/failure.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/strings.dart';
import '../../data/models/comment_model.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final LikePostUseCase likePostUseCase;
  final GetAllCommentUseCase getAllCommentUseCase;
  final CommentUseCase commentUseCase;

  PostBloc({
    required this.likePostUseCase,
    required this.getAllCommentUseCase,
    required this.commentUseCase,
  }) : super(const PostState()) {
    on<PostEvent>(handleEvent);
  }

  Future<void> handleEvent(event, emit) async {
    if (event is LikePostEvent) {
      emit(state.copyWith(postLikedSuccess: !state.postLikedSuccess, error: ''));
      final likePostResponse = await likePostUseCase.call(event.serviceId);
      likePostResponse.fold((failure) {
        emit(state.copyWith(
            loading: false,
            error: mapFailureToMessage(failure),
            postLikedSuccess: state.postLikedSuccess ? false : true));
      }, (_) {
        emit(state.copyWith(
            loading: false,
            postLikedSuccess: state.postLikedSuccess ? true : false));
      });
    }
    if (event is LocalLike) {
      emit(state.copyWith(error: ""));
    }

    // Event handler for retrieving all comments...
    if (event is GetAllCommentsEvent) {
      emit(state.copyWith(loading: true, error: ""));
      if (emit.isDone) ;

      final getAllCommentsOrFailure =
      await getAllCommentUseCase(event.serviceId, 1);

      getAllCommentsOrFailure.fold((failure) {
        emit(state.copyWith(
            error: mapFailureToMessage(failure), loading: false));
      }, (comments) {
        emit(state.copyWith(
            loading: false,
            error: "",
            currentPage: 1,
            comments: comments));
      });
    }

    if (event is AddCommentEvent) {
      if (emit.isDone) return;
      final failureOrAddComment =
      await commentUseCase(event.serviceId, event.comment);

      failureOrAddComment.fold((failure) {
        emit(state.copyWith(loading: false));
      }, (comment) {
        final List<CommentModel> secondList = List.from(state.comments);
        secondList.insert(0, comment);
        emit(state.copyWith(
            loading: false,
            comments: secondList));
      });
    }

    if (event is LoadNextCommentsEvent) {
      emit(state.copyWith(
          loadingNextPage: true, error: ""));
      if (emit.isDone) return;

      if (!state.hasReachedTheEnd) {
        final servicesResult =
        await getAllCommentUseCase(event.serviceId, state.currentPage + 1);

        servicesResult.fold((failure) {
          emit(state.copyWith(
              loadingNextPage: false,
              hasReachedTheEnd: true));
        }, (comments) {
          if (comments.isEmpty) {
            emit(state.copyWith(
                loadingNextPage: false, error: "", hasReachedTheEnd: true));
          } else {
            emit(state.copyWith(
              loadingNextPage: false,
              error: "",
              currentPage: state.currentPage + 1,
              comments : (state.comments + comments).toSet().toList(),
            ));
          }
        });
      }
    }

  }
}
