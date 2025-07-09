import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:kagojkolom/core/global/logger.dart';
import 'package:kagojkolom/features/auth/domain/entity/user_entity.dart';
import 'package:kagojkolom/features/auth/domain/usecases/user_usecases.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUsecases userUsecases;

  UserEntity? _currentUser;

  UserBloc(this.userUsecases) : super(UserInitial()) {
    on<LoadUserEvent>(loadUserEvent);
    on<UpdateUserDetailsButtonPressedEvent>(
      updateUserDetailsButtonPressedEvent,
    );
    on<ResetPasswordButtonPressedEvent>(resetPasswordButtonPressedEvent);
  }

  FutureOr<void> loadUserEvent(LoadUserEvent event, Emitter<UserState> emit) {
    _currentUser = event.userEntity;
    emit(LoggedInUserState(userEntity: event.userEntity));
  }

  FutureOr<void> updateUserDetailsButtonPressedEvent(
    UpdateUserDetailsButtonPressedEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());
    final updatedUser = await userUsecases.updateUserDetails(
      event.firstName,
      event.lastName,
      event.profilePictureUrl,
    );
    logger.d('update button - bloc - success');

    updatedUser.fold(
      (failure) {
        logger.d('update button - bloc - failure --> ${failure.message}');
        emit(UpdateUserDetailsFailedActionState(message: failure.message));
      },
      (entity) {
        logger.d('update button - bloc - success - foldright');
        _currentUser = entity;
        emit(UpdateUserDetailsSuccessActionState());
        emit(LoggedInUserState(userEntity: entity));
      },
    );
  }

  FutureOr<void> resetPasswordButtonPressedEvent(
    ResetPasswordButtonPressedEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());
    final result = await userUsecases.resetPassword(event.email);
    return result.fold(
      (failure) =>
          emit(ResetPasswordEmailSentFailedEvent(message: failure.message)),
      (_) {
        emit(ResetPasswordEmailSentSuccessEvent());
        emit(LoggedInUserState(userEntity: _currentUser!));
      },
    );
  }
}
