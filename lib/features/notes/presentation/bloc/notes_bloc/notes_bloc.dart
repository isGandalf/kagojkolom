import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kagojkolom/core/global/logger.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/domain/usecases/notes_usecases.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_page_type.dart';
import 'package:meta/meta.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NoteUsecases noteUsecases;
  NotesBloc(this.noteUsecases) : super(NotesInitial()) {
    on<NotePageInitialEvent>(notePageInitialEvent);
    on<NotePageOptionPressedEvent>(notePageOptionPressedEvent);
    on<AddNewNoteButtonPressedEvent>(addNewNoteButtonPressedEvent);
    on<UpdateNoteButtonPressedEvent>(updateNoteButtonPressedEvent);
    on<DeleteNoteButtonPressedEvent>(deleteNoteButtonPressedEvent);
    on<FavouriteButtonPressedEvent>(favouriteButtonPressedEvent);
  }

  // Initial state - In this state the homepage will load with all the notes
  FutureOr<void> notePageInitialEvent(
    NotePageInitialEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoadingState(notePageType: event.notePageType));
    final result = await noteUsecases.fetchNotes();

    if (result.isLeft()) {
      result.fold((l) => logger.e(l.message), (r) => null);
      emit(NotesLoadingFailedState(notePageType: event.notePageType));
      return;
    }

    result.fold(
      (failure) =>
          emit(NotesLoadingFailedState(notePageType: event.notePageType)),
      (allNotes) {
        final myNotes =
            allNotes.where((note) => note.isDeleted == false).toList();
        final favNotes =
            allNotes.where((note) => note.isFavourite == true).toList();
        final trashNotes =
            allNotes.where((note) => note.isDeleted == true).toList();
        // print(myNotes.length);
        // print(favNotes.length);
        // print(trashNotes.length);
        // allNotes.forEach((note) {
        //   print(
        //     'Note ${note.noteId}: isFavourite=${note.isFavourite}, isDeleted=${note.isDeleted}',
        //   );
        // });
        emit(
          NotesLoadedState(
            notePageType: NotePageType.myNotes,
            myNotes: myNotes,
            favNotes: favNotes,
            sharedWithMeNotes: [],
            trashNotes: trashNotes,
          ),
        );
      },
    );
  }

  // when user selects an option from left column
  FutureOr<void> notePageOptionPressedEvent(
    NotePageOptionPressedEvent event,
    Emitter<NotesState> emit,
  ) {
    if (state is NotesLoadedState) {
      final currentState = state as NotesLoadedState;
      emit(currentState.copyWith(notePageType: event.selectedNotePage));
    }
  }

  // Add new note
  FutureOr<void> addNewNoteButtonPressedEvent(
    AddNewNoteButtonPressedEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoadingState(notePageType: event.notePageType));
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
    emit(NotesLoadingState(notePageType: event.notePageType));

    final noteList = await noteUsecases.fetchNotes();

    return noteList.fold(
      (failure) {
        logger.e(failure.toString());
        emit(NotesLoadingFailedState(notePageType: event.notePageType));
      },
      (allNotes) {
        final myNotes = allNotes;
        final favNotes =
            allNotes.where((note) => note.isFavourite == true).toList();
        final trashNotes =
            allNotes.where((note) => note.isDeleted == true).toList();

        NotePageType currentPage = NotePageType.myNotes;
        if (state is NotesLoadedState) {
          currentPage = (state as NotesLoadedState).notePageType;
        }
        emit(
          NotesLoadedState(
            myNotes: myNotes,
            notePageType: currentPage,
            favNotes: favNotes,
            trashNotes: trashNotes,
            sharedWithMeNotes: [],
          ),
        );
      },
    );
  }

  // Update an existing note
  FutureOr<void> updateNoteButtonPressedEvent(
    UpdateNoteButtonPressedEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoadingState(notePageType: event.notePageType));
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

    emit(NotesLoadingState(notePageType: event.notePageType));
    final noteList = await noteUsecases.fetchNotes();
    // NotePageType currentPage = NotePageType.myNotes;
    // if (noteList.isRight()) {
    //   if (state is NotesLoadedState) {
    //     print('in bloc before = $currentPage');
    //     currentPage = (state as NotesLoadedState).notePageType;
    //     print('in bloc after = $currentPage');
    //   }
    // }
    return noteList.fold(
      (failure) {
        logger.e(failure.toString());
        emit(NotesLoadingFailedState(notePageType: event.notePageType));
      },
      (allNotes) {
        final myNotes = allNotes;
        final favNotes =
            allNotes.where((note) => note.isFavourite == true).toList();
        final trashNotes =
            allNotes.where((note) => note.isDeleted == true).toList();

        emit(
          NotesLoadedState(
            notePageType: event.notePageType,
            myNotes: myNotes,
            favNotes: favNotes,
            trashNotes: trashNotes,
            sharedWithMeNotes: [],
          ),
        );
      },
    );
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
    return noteList.fold(
      (failure) {
        logger.e(failure.toString());
        emit(NotesLoadingFailedState(notePageType: event.notePageType));
      },
      (allNotes) {
        final myNotes = allNotes;
        final favNotes =
            allNotes.where((note) => note.isFavourite == true).toList();
        final trashNotes =
            allNotes.where((note) => note.isDeleted == true).toList();
        NotePageType currentPage = NotePageType.myNotes;
        if (state is NotesLoadedState) {
          currentPage = (state as NotesLoadedState).notePageType;
        }
        emit(
          NotesLoadedState(
            notePageType: currentPage,
            favNotes: favNotes,
            trashNotes: trashNotes,
            myNotes: myNotes,
            sharedWithMeNotes: [],
          ),
        );
      },
    );
  }

  FutureOr<void> favouriteButtonPressedEvent(
    FavouriteButtonPressedEvent event,
    Emitter<NotesState> emit,
  ) async {
    final result = await noteUsecases.addToFavourite(event.noteId);

    if (result.isLeft()) {
      result.fold((l) => logger.e(l.message), (r) => null);
      emit(UpdateNoteFailedState());
    }

    emit(UpdateNoteSuccessState());

    emit(NotesLoadingState(notePageType: event.notePageType));

    final noteList = await noteUsecases.fetchNotes();
    return noteList.fold(
      (failure) =>
          emit(NotesLoadingFailedState(notePageType: event.notePageType)),
      (allNotes) {
        final myNotes = allNotes;
        final favNotes =
            allNotes.where((note) => note.isFavourite == true).toList();
        final trashNotes =
            allNotes.where((note) => note.isDeleted == true).toList();
        emit(
          NotesLoadedState(
            notePageType: event.notePageType,
            myNotes: myNotes,
            favNotes: favNotes,
            sharedWithMeNotes: [],
            trashNotes: trashNotes,
          ),
        );
      },
    );
  }
}
