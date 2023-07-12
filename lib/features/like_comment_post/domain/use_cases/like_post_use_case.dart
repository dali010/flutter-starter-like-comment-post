import 'package:dartz/dartz.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/domain/repositories/like_comment_repository.dart';

import '../../../../core/utils/failure.dart';

class LikePostUseCase {
  final LikeCommentRepository repository;

  LikePostUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(String serviceId) async {
    return await repository.likePost(serviceId);
  }
}