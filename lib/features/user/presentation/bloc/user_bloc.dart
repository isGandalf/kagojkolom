import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kagojkolom/features/auth/domain/entity/user_entity.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUserEvent>(loadUserEvent);
  }

  FutureOr<void> loadUserEvent(LoadUserEvent event, Emitter<UserState> emit) {
    emit(LoggedInUserState(userEntity: event.userEntity));
  }
}
