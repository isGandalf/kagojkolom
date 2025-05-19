part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class SignupButtonPressedEvent extends SignupEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  SignupButtonPressedEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
}
