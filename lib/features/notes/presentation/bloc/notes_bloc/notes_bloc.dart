import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kagojkolom/core/global/logger.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/domain/usecases/notes_usecases.dart';
import 'package:meta/meta.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NoteUsecases noteUsecases;
  NotesBloc(this.noteUsecases) : super(NotesInitial()) {
    on<NotePageInitialEvent>(notePageInitialEvent);
    on<AddNewNoteButtonPressedEvent>(addNewNoteButtonPressedEvent);
    on<UpdateNoteButtonPressedEvent>(updateNoteButtonPressedEvent);
    on<DeleteNoteButtonPressedEvent>(deleteNoteButtonPressedEvent);
  }

  // Initial state - In this state the homepage will load with all the notes
  FutureOr<void> notePageInitialEvent(
    NotePageInitialEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoadingState());
    final result = await noteUsecases.fetchNotes();
    return result.fold((failure) {
      logger.e(failure.toString());
      emit(NotesLoadingFailedState());
    }, (list) => emit(NotesLoadedState(allNotes: list)));
  }

  // Add new note
  FutureOr<void> addNewNoteButtonPressedEvent(
    AddNewNoteButtonPressedEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoadingState());
    final result = await noteUsecases.addNewNote(
      event.noteTitle,
      event.noteContent,
    );

    if (result.isLeft()) {
      result.fold((l) => logger.e(l.message), (r) => null);
      emit(NewNoteAddFailedState());
      return;
    }

    emit(NewNoteAddSuccessState());
    emit(NotesLoadingState());
    final noteList = await noteUsecases.fetchNotes();
    return noteList.fold((failure) {
      logger.e(failure.toString());
      emit(NotesLoadingFailedState());
    }, (allNotes) => emit(NotesLoadedState(allNotes: allNotes)));
  }

  // Update an existing note
  FutureOr<void> updateNoteButtonPressedEvent(
    UpdateNoteButtonPressedEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoadingState());
    final result = await noteUsecases.updateNote(
      event.noteId,
      event.noteTitle,
      event.noteContent,
      event.createdAt,
      event.isPrivate,
      event.isFavourite,
      event.sharedWithUserIds,
    );

    if (result.isLeft()) {
      result.fold((l) => logger.e(l.message), (r) => null);
      emit(UpdateNoteFailedState());
      return;
    }

    emit(UpdateNoteSuccessState());

    emit(NotesLoadingState());
    final noteList = await noteUsecases.fetchNotes();
    return noteList.fold((failure) {
      logger.e(failure.toString());
      emit(NotesLoadingFailedState());
    }, (allNotes) => emit(NotesLoadedState(allNotes: allNotes)));
  }

  FutureOr<void> deleteNoteButtonPressedEvent(
    DeleteNoteButtonPressedEvent event,
    Emitter<NotesState> emit,
  ) async {
    final result = await noteUsecases.deleteNote(event.noteId);

    if (result.isLeft()) {
      result.fold((l) => logger.e(l.message), (r) => null);
      emit(DeleteNoteFailedState(message: 'Failed to delete note'));
      return;
    }

    emit(DeleteNoteSuccessState());

    final noteList = await noteUsecases.fetchNotes();
    return noteList.fold((failure) {
      logger.e(failure.toString());
      emit(NotesLoadingFailedState());
    }, (allNotes) => emit(NotesLoadedState(allNotes: allNotes)));
  }
}
