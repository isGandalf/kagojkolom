part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginButtonPressedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressedEvent({required this.email, required this.password});
}

final class SignOutButtonPressedEvent extends LoginEvent {}
