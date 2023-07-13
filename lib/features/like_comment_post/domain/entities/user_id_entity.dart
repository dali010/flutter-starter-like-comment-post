import 'package:equatable/equatable.dart';

class UserIdEntity extends Equatable {
  final String id;
  final String name;
  final String lastname;
  final String profilePicUrl;

  UserIdEntity({
    this.id = "",
    this.name = "",
    this.lastname = "",
    this.profilePicUrl = "",
  });

  factory UserIdEntity.fromJson(Map<dynamic, dynamic> json) {
    return UserIdEntity(
      id: json['id'],
      name: json['name'],
      lastname: json['lastname'],
      profilePicUrl: json['profilePicUrl'],
    );
  }

  @override
  List<Object?> get props => [id, name, lastname, profilePicUrl];
}
