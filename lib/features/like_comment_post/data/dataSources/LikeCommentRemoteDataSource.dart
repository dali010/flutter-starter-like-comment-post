import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../../core/utils/exceptions.dart';
import '../../../../core/utils/strings.dart';

abstract class LikeCommentRemoteDataSource {
  Future<Unit> likePost(String serviceId);
}

class LikeCommentRemoteDataSourceImpl extends LikeCommentRemoteDataSource {
  final http.Client client;

  LikeCommentRemoteDataSourceImpl({required this.client});
  @override
  Future<Unit> likePost(String serviceId) async {

    // API call to follow a user
    final response = await http.put(Uri.parse("${Strings.baseUrl}/like/$serviceId"), headers: {
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
}

String getErrorMessage(Response response) {
  final errorDecodedJson = json.decode(response.body) as Map<String, dynamic>;
  final error = errorDecodedJson["message"] as String;
  return error;
}