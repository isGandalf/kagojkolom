part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class LoadUserEvent extends UserEvent {
  final UserEntity userEntity;

  LoadUserEvent({required this.userEntity});
}

final class UpdateUserDetailsButtonPressedEvent extends UserEvent {
  final String firstName;
  final String lastName;
  final String profilePictureUrl;

  UpdateUserDetailsButtonPressedEvent({
    required this.firstName,
    required this.lastName,
    required this.profilePictureUrl,
  });
}
