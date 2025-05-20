part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoadingState extends UserState {}

final class LoggedInUserState extends UserState {
  final UserEntity userEntity;

  LoggedInUserState({required this.userEntity});
}
