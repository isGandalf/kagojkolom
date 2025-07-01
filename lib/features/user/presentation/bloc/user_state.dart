part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoadingState extends UserState {}

final class LoggedInUserState extends UserState {
  final UserEntity userEntity;

  LoggedInUserState({required this.userEntity});
}

// Action states
final class UserActionStates extends UserState {}

final class UpdateUserDetailsSuccessActionState extends UserActionStates {}

final class UpdateUserDetailsFailedActionState extends UserActionStates {
  final String message;

  UpdateUserDetailsFailedActionState({required this.message});
}
