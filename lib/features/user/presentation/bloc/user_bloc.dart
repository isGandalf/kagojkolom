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
  UserBloc(this.userUsecases) : super(UserInitial()) {
    on<LoadUserEvent>(loadUserEvent);
    on<UpdateUserDetailsButtonPressedEvent>(
      updateUserDetailsButtonPressedEvent,
    );
  }

  FutureOr<void> loadUserEvent(LoadUserEvent event, Emitter<UserState> emit) {
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
        emit(UpdateUserDetailsSuccessActionState());
        emit(LoggedInUserState(userEntity: entity));
      },
    );
  }
}
