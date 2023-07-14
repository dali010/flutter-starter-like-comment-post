import 'package:equatable/equatable.dart';
import 'package:flutter_starter_like_comment/features/like_comment_post/data/models/user_id_model.dart';

class CommentEntity extends Equatable {
  final String id;
  final dynamic userId;
  final String serviceId;
  final UserIdModel commentor;
  final String comment;

  const CommentEntity({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.commentor,
    required this.comment,
  });

  List<Object?> get props => [id, userId, commentor, serviceId, comment];
}

/*
 "_id": "64604788e88fda7f2e01f783",
                "user_id": "645e621e9f59cde4c6d0c9fa",
                "service_id": "646024999f59cde4c6d100ed",
                "comments": "tahe is the legend",
                "deletedAt": null,
                "createdAt": "2023-05-14T02:29:28.605Z",
                "updatedAt": "2023-05-14T02:29:28.605Z"
            },
*/
