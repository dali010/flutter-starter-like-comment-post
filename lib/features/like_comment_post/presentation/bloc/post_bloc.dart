import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/domain/use_cases/like_post_use_case.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/presentation/bloc/post_event.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/presentation/bloc/post_state.dart';

import '../../../../core/utils/failure.dart';
import '../../../../core/utils/strings.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final LikePostUseCase likePostUseCase;

  PostBloc({
    required this.likePostUseCase,
  }) : super(const PostState()) {
    on<PostEvent>(handleEvent);
  }

  Future<void> handleEvent(event, emit) async {
    if (event is LikePostEvent) {
      emit(state.copyWith(postLikedSuccess: !state.postLikedSuccess, error: ''));
      final likePostResponse = await likePostUseCase.call(event.serviceId);
      likePostResponse.fold((failure) {
        print("saydouun ${mapFailureToMessage(failure)}");
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
  }

  String mapFailureToMessage(Failure failure, {String? errorMessage}) {
    if (failure is ServerFailure) {
      return isArabic(failure.message)
          ? failure.message
          : errorMessage ?? Strings.SERVER_FAILURE_MESSAGE;
    } else if (failure is ServerFailure) {
      return "حدثت مشكلة.\n الرجاء معاودة المحاولة في وقت لاحق.";
    } else if (failure is OfflineFailure) {
      return Strings.OFFLINE_FAILURE_MESSAGE;
    } else {
      return "Unexpected Error , Please try again later .";
    }
  }

  bool isArabic(String text) {
    LineSplitter ls = const LineSplitter();
    List<String> lines = ls.convert(text);

    if (lines.isEmpty) {
      return true;
    }

    var firstLine = lines.first.split(' ');
    if (firstLine.isEmpty) {
      return true;
    }

    for (var i = 0; i < firstLine[0].length; i++) {
      final codeUnit = firstLine[0].codeUnitAt(i);
      if ((codeUnit >= 0x0600 && codeUnit <= 0x06FF)) {
        return true;
      }
    }
    return false;
  }
}
