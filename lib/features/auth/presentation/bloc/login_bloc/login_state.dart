part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

/* NON-ACTION STATES */
final class LoginStandardState extends LoginState {}

final class LoginLoadingState extends LoginStandardState {}

/* ACTION STATES */
final class LoginActionState extends LoginState {}

final class LoginSuccessActionState extends LoginActionState {
  final UserEntity userEntity;
  LoginSuccessActionState({required this.userEntity});
}

final class LoginFailedActionState extends LoginActionState {
  final String message;

  LoginFailedActionState({required this.message});
}
