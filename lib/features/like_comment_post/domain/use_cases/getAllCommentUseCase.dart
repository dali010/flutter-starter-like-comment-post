import 'package:dartz/dartz.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/domain/repositories/like_comment_repository.dart';

import '../../../../core/utils/failure.dart';
import '../../data/models/comment_model.dart';

class GetAllCommentUseCase {
  final LikeCommentRepository repository;

  GetAllCommentUseCase({required this.repository});

  Future<Either<Failure, List<CommentModel>>> call(String serviceId) async {
    return await repository.getAllComments(serviceId);
  }
}
