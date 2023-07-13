import 'package:dartz/dartz.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/domain/repositories/like_comment_repository.dart';

import '../../../../core/utils/failure.dart';
import '../../data/models/comment_model.dart';

class CommentUseCase {
  final LikeCommentRepository repository;

  CommentUseCase({required this.repository});

  Future<Either<Failure, CommentModel>> call(
      String serviceId, String comment) async {
    return await repository.addComment(serviceId, comment);
  }
}
