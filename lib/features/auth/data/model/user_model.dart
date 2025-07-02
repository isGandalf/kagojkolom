import 'package:kagojkolom/features/auth/domain/entity/user_entity.dart';

class UserModel {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String profilePictureUrl;

  const UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePictureUrl,
  });

  // convert from model to entity
  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      profilePictureUrl: profilePictureUrl,
    );
  }

  // convert from entity to Model
  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      userId: user.userId,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      profilePictureUrl: user.profilePictureUrl,
    );
  }

  // from firestore json
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      profilePictureUrl: json['profilePictureUrl'] as String,
    );
  }

  // model to firestore json
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
