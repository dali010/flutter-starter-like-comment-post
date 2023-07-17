import 'package:dartz/dartz.dart';

import '../../../../core/utils/failure.dart';
import '../../data/models/comment_model.dart';

abstract class LikeCommentRepository {
  Future<Either<Failure, Unit>> likePost(String serviceId);

  Future<Either<Failure, List<CommentModel>>> getAllComments(String serviceId, int page);

  Future<Either<Failure, CommentModel>> addComment(String serviceId, String comment);
}
