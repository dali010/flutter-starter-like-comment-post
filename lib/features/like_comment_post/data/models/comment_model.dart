import 'package:flutter_starter_like_comment/features/like_comment_post/data/models/user_id_model.dart';

import '../../domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  const CommentModel(
      {required super.id,
      required super.userId,
      required super.serviceId,
      required super.commentor,
      required super.comment});

  factory CommentModel.fromJson(Map<dynamic, dynamic> json) {
    return CommentModel(
      id: json["_id"] ?? "",
      userId: json["user_id"],
      commentor: json["student_id"] != null ? UserIdModel.fromJson(json["student_id"]): UserIdModel.fromJson(json["teacher_id"]),
      serviceId: json["service_id"] ?? "",
      comment: json["comments"] ?? "",
    );
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data["_id"] = id;
    final UserIdModel usersModel = userId as UserIdModel;
    data["user_id"] = usersModel.toJson();
    final UserIdModel studentModel = commentor as UserIdModel;
    data["student_id"] = studentModel.toJson();
    final UserIdModel teacherModel = commentor as UserIdModel;
    data["teacher_id"] = teacherModel.toJson();
    data["service_id"] = serviceId;
    data["comment"] = comment;

    return data;
  }
}
