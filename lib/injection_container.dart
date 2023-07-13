import 'package:flutter_starter_like_comment/features/like_comment_post/data/dataSources/LikeCommentRemoteDataSource.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/data/repositories/like_comment_repository_impl.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/domain/repositories/like_comment_repository.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/domain/use_cases/like_post_use_case.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/presentation/bloc/post_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => PostBloc(likePostUseCase: sl()));

  sl.registerLazySingleton(() => LikePostUseCase(repository: sl()));

  sl.registerLazySingleton<LikeCommentRepository>(() =>
      LikeCommentRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<LikeCommentRemoteDataSource>(
      () => LikeCommentRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
}
