import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class LikePostEvent extends PostEvent {
  final String serviceId;

  const LikePostEvent({
    required this.serviceId,
  });
}

class LocalLike extends PostEvent {}

class GetAllCommentsEvent extends PostEvent {
  const GetAllCommentsEvent({required this.serviceId});

  final String serviceId;
}

// Event to add a comment to a service
class AddCommentEvent extends PostEvent {
  final String serviceId;
  final String comment;

  const AddCommentEvent({required this.serviceId, required this.comment});

  @override
  List<Object> get props => [serviceId, comment];

}

class LoadNextCommentsEvent extends PostEvent {
  const LoadNextCommentsEvent({required this.serviceId});

  final String serviceId;
}


