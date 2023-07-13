import '../../domain/entities/user_id_entity.dart';

class UserIdModel extends UserIdEntity {
  UserIdModel({
    required super.id,
    required super.name,
    required super.lastname,
    required super.profilePicUrl,
  });

  factory UserIdModel.fromJson(Map<String, dynamic> json) {
    return UserIdModel(
      id: json["_id"],
      name: json["name"],
      lastname: json['lastname'],
      profilePicUrl: json['profilePicUrl'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastname': lastname,
      'profilePicUrl': profilePicUrl,
    };
  }
}
