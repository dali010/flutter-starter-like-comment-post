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
