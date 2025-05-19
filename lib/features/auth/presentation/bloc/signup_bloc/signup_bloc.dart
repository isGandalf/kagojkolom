import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:kagojkolom/core/global/logger.dart';
import 'package:kagojkolom/features/auth/domain/usecases/user_usecases.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserUsecases userUsecases;

  SignupBloc(this.userUsecases) : super(SignupInitial()) {
    on<SignupButtonPressedEvent>(signupButtonPressedEvent);
  }

  FutureOr<void> signupButtonPressedEvent(
    SignupButtonPressedEvent event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupLoadingState());
    logger.d('Data received - ${event.email} , ${event.password}');
    final result = await userUsecases.createNewUser(
      event.firstName,
      event.lastName,
      event.email,
      event.password,
    );
    result.fold(
      (failure) {
        logger.e('Signup failed: ${failure.message}');
        emit(SignupFailedActionState(message: failure.message));
      },
      (_) => emit(
        SignupSuccessActionState(message: 'Signup success. Please login.'),
      ),
    );
  }
}
