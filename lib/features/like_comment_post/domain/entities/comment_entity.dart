import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {

    final String id ;
    final dynamic userId;
    final String serviceId;
    final String comment ;

    const CommentEntity({
      required this.id,
      required this.userId,
      required this.serviceId,
      required this.comment,
});


    factory CommentEntity.fromJson(Map<dynamic, dynamic> json) {
      return CommentEntity(
        id: json['_id'],
        userId: json['user_id'],
        serviceId: json['service_id'],
        comment: json['comment'],
      );
    }

    Map<dynamic, dynamic> toJson() {
      final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
      data['_id'] = id;
      data['user_id'] = userId;
      data['service_id'] = serviceId;
      data['comment'] = comment;
      return data;
    }


    List<Object?> get props => [id,userId,serviceId,comment];

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