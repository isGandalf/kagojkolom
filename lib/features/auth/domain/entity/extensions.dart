import 'package:kagojkolom/features/auth/domain/entity/user_entity.dart';

extension UserEntityCopyWith on UserEntity {
  UserEntity copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? profilePictureUrl,
  }) {
    return UserEntity(
      userId: userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }
}
