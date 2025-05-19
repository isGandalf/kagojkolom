part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

// N O N A C T I O N - S T A T E S
final class SignupStandardState extends SignupState {}

final class SignupLoadingState extends SignupStandardState {}

// A C T I O N - S T A T E S
final class SignupActionState extends SignupState {}

final class SignupSuccessActionState extends SignupActionState {
  final String message;
  SignupSuccessActionState({required this.message});
}

final class SignupFailedActionState extends SignupActionState {
  final String message;
  SignupFailedActionState({required this.message});
}
