import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../../../core/utils/exceptions.dart';
import '../../../../core/utils/strings.dart';
import '../models/comment_model.dart';

abstract class LikeCommentRemoteDataSource {
  Future<Unit> likePost(String serviceId);
  Future<List<CommentModel>> getAllComments(String serviceId);
  Future<CommentModel> addComment(String serviceId, String comment);
}

class LikeCommentRemoteDataSourceImpl extends LikeCommentRemoteDataSource {
  final http.Client client;

  LikeCommentRemoteDataSourceImpl({required this.client});

  @override
  Future<Unit> likePost(String serviceId) async {
    final response = await http
        .put(Uri.parse("${Strings.baseUrl}/like/$serviceId"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Strings.token}',
      'Content-Type': 'application/json'
    });

    print("LikePostResponse: ${json.decode(response.body)} id: $serviceId");
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException(message: getErrorMessage(response));
    }
  }

  @override
  Future<List<CommentModel>> getAllComments(String serviceId) async {

    final response = await http.get(
        Uri.parse("${Strings.baseUrl}/comments/$serviceId"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Strings.token}'
        });

    print("GetAllComments: ${response.body} ");

    if (response.statusCode == 200) {
      final List decodedJson =
      json.decode(response.body)["data"]["docs"] as List;

      final List<CommentModel> commentsModels = decodedJson
          .map<CommentModel>(
              (commentsModel) => CommentModel.fromJson(commentsModel))
          .where((commentsModel) => commentsModel.userId != null)
          .toList();

      return commentsModels;
    } else {
      throw ServerException(message: getErrorMessage(response));
    }
  }

  @override
  // Add Comment...
  Future<CommentModel> addComment(String serviceId, String comment) async {
    final body = {"comments": comment};

    final response = await client.put(
        Uri.parse("${Strings.baseUrl}/api/v1/comments/$serviceId"),
        body: body,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Strings.token}'
        });

    print("AddComment service id: $serviceId");
    print("AddComment: ${response.body} ");

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body)["comment"];
      final CommentModel comment = CommentModel.fromJson(decodedJson);
      return Future.value(comment);
    } else {
      throw ServerException(message: getErrorMessage(response));
    }
  }
}

String getErrorMessage(Response response) {
  final errorDecodedJson = json.decode(response.body) as Map<String, dynamic>;
  final error = errorDecodedJson["message"] as String;
  return error;
}
