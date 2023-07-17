import 'package:dartz/dartz.dart';
import 'package:flutter_starter_like_comment/core/utils/failure.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/data/dataSources/LikeCommentRemoteDataSource.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/domain/repositories/like_comment_repository.dart';

import '../../../../core/network/network_info.dart';
import '../../../../core/utils/exceptions.dart';
import '../models/comment_model.dart';

class LikeCommentRepositoryImpl extends LikeCommentRepository {
  final LikeCommentRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LikeCommentRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> likePost(String serviceId) async {
    if (await networkInfo.isConnected) {
      try {
        final services = await remoteDataSource.likePost(serviceId);
        return Right(services);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure(message: "Unknown Error"));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<CommentModel>>> getAllComments(
      String serviceId, int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAllLikes = await remoteDataSource.getAllComments(serviceId, page);
        return Right(remoteAllLikes);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure(message: "Unknown Error"));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, CommentModel>> addComment(
      String serviceId, String comments) async {
    if (await networkInfo.isConnected) {
      try {
        final comment = await remoteDataSource.addComment(serviceId, comments);
        return Right(comment);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure(message: "Unknown Error"));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}