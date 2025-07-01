import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:kagojkolom/features/auth/domain/entity/user_entity.dart';
import 'package:kagojkolom/features/auth/domain/usecases/user_usecases.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserUsecases userUsecases;

  LoginBloc(this.userUsecases) : super(LoginInitial()) {
    on<LoginButtonPressedEvent>(loginButtonPressedEvent);
    on<SignOutButtonPressedEvent>(signOutButtonPressedEvent);
  }

  FutureOr<void> loginButtonPressedEvent(
    LoginButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());
    final userEntity = await userUsecases.loginUser(
      event.email,
      event.password,
    );
    return userEntity.fold(
      (failure) {
        emit(LoginFailedActionState(message: failure.message));
      },
      (entity) {
        emit(LoginSuccessActionState(userEntity: entity));
      },
    );
  }

  FutureOr<void> signOutButtonPressedEvent(
    SignOutButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());
    final result = await userUsecases.userSignOut();

    return result.fold(
      (failure) => emit(SignOutFailedActionState(message: failure.message)),
      (_) {
        emit(SignOutSuccessActionState());
        //emit(LoginInitial());
        emit(LoginStandardState());
      },
    );
  }
}
