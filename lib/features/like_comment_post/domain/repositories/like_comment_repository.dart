import 'package:dartz/dartz.dart';

import '../../../../core/utils/failure.dart';

abstract class LikeCommentRepository {
  Future<Either<Failure, Unit>> likePost(String serviceId);
}