import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    on<DeleteNoteForeverButtonPressedEvent>(
      deleteNoteForeverButtonPressedEvent,
    );
    on<ShareButtonPressedEvent>(shareButtonPressedEvent);
    on<DeleteAllNotesButtonPressedEvent>(deleteAllNotesButtonPressedEvent);
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
            myNotes.where((note) => note.isFavourite == true).toList();
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
  ) async {
    if (state is NotesLoadedState) {
      final currentState = state as NotesLoadedState;
      emit(currentState.copyWith(notePageType: event.selectedNotePage));

      if (event.selectedNotePage == NotePageType.sharedWithMe) {
        final sharedNotes = await noteUsecases.fetchNotesSharedWithMe();

        return sharedNotes.fold(
          (failure) => emit(
            NotesLoadingFailedState(notePageType: event.selectedNotePage),
          ),
          (sharedNotes) {
            emit(
              currentState.copyWith(
                sharedWithMeNotes: sharedNotes,
                notePageType: event.selectedNotePage,
              ),
            );
          },
        );
      }
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
        final myNotes =
            allNotes.where((note) => note.isDeleted == false).toList();

        final favNotes =
            myNotes.where((note) => note.isFavourite == true).toList();
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
        final myNotes =
            allNotes.where((note) => note.isDeleted == false).toList();
        final favNotes =
            myNotes.where((note) => note.isFavourite == true).toList();
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

  // Delete a note (sends to Trash)
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
    emit(NotesLoadingState(notePageType: event.notePageType));

    final noteList = await noteUsecases.fetchNotes();
    return noteList.fold(
      (failure) {
        logger.e(failure.toString());
        emit(NotesLoadingFailedState(notePageType: event.notePageType));
      },
      (allNotes) {
        final myNotes =
            allNotes.where((note) => note.isDeleted == false).toList();
        final favNotes =
            myNotes.where((note) => note.isFavourite == true).toList();
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

  // Change note isFavourite flag to true
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
        final myNotes =
            allNotes.where((note) => note.isDeleted == false).toList();
        final favNotes =
            myNotes.where((note) => note.isFavourite == true).toList();
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

  // Delete a note forever (delete from db)
  FutureOr<void> deleteNoteForeverButtonPressedEvent(
    DeleteNoteForeverButtonPressedEvent event,
    Emitter<NotesState> emit,
  ) async {
    final result = await noteUsecases.deleteNoteFromDb(event.noteId);

    if (result.isLeft()) {
      result.fold((l) => logger.e(l.message), (r) => null);
      emit(DeleteNoteForeverFailedState(message: 'Failed to delete note'));
      return;
    }

    emit(DeleteNoteForeverSuccessState());
    emit(NotesLoadingState(notePageType: event.notePageType));

    final noteList = await noteUsecases.fetchNotes();
    return noteList.fold(
      (failure) {
        logger.e(failure.toString());
        emit(NotesLoadingFailedState(notePageType: event.notePageType));
      },
      (allNotes) {
        final myNotes =
            allNotes.where((note) => note.isDeleted == false).toList();
        final favNotes =
            myNotes.where((note) => note.isFavourite == true).toList();
        final trashNotes =
            allNotes.where((note) => note.isDeleted == true).toList();
        emit(
          NotesLoadedState(
            notePageType: NotePageType.trash,
            favNotes: favNotes,
            trashNotes: trashNotes,
            myNotes: myNotes,
            sharedWithMeNotes: [],
          ),
        );
      },
    );
  }

  FutureOr<void> shareButtonPressedEvent(
    ShareButtonPressedEvent event,
    Emitter<NotesState> emit,
  ) async {
    await noteUsecases.shareNote(event.noteId, event.email);
  }

  FutureOr<void> deleteAllNotesButtonPressedEvent(
    DeleteAllNotesButtonPressedEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesDeletingState());
    final result = await noteUsecases.deleteAllNotes();

    return result.fold(
      (failure) async {
        emit(DeleteAllNotesFailedState(message: '${failure.message}.'));
        final noteList = await noteUsecases.fetchNotes();
        noteList.fold(
          (failure) =>
              emit(NotesLoadingFailedState(notePageType: NotePageType.myNotes)),
          (notes) {
            final myNotes =
                notes.where((note) => note.isDeleted == false).toList();
            final favNotes =
                myNotes.where((note) => note.isFavourite == true).toList();
            final trashNotes =
                notes.where((note) => note.isDeleted == true).toList();
            emit(
              DeleteAllNotesFailedState(
                message: 'Total notes remaining are $myNotes',
              ),
            );
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
      },
      (message) async {
        emit(DeleteAllNotesSuccessState(message: message));
        final noteList = await noteUsecases.fetchNotes();
        noteList.fold(
          (failure) =>
              emit(NotesLoadingFailedState(notePageType: NotePageType.myNotes)),
          (notes) {
            final myNotes =
                notes.where((note) => note.isDeleted == false).toList();
            final favNotes =
                myNotes.where((note) => note.isFavourite == true).toList();
            final trashNotes =
                notes.where((note) => note.isDeleted == true).toList();
            emit(
              DeleteAllNotesFailedState(
                message: 'Total notes remaining are $myNotes',
              ),
            );
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
      },
    );
  }
}
