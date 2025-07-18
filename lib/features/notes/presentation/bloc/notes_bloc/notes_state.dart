part of 'notes_bloc.dart';

@immutable
sealed class NotesState {}

final class NotesInitial extends NotesState {}

// Non-action states
final class NotesNonActionState extends NotesState {}

final class NotesLoadingState extends NotesNonActionState {
  final NotePageType notePageType;

  NotesLoadingState({required this.notePageType});
}

final class NotesDeletingState extends NotesNonActionState {}

final class NotesLoadingFailedState extends NotesNonActionState {
  final NotePageType notePageType;

  NotesLoadingFailedState({required this.notePageType});
}

final class NotesLoadedState extends NotesNonActionState {
  final NotePageType notePageType;
  final List<NoteEntity> myNotes;
  final List<NoteEntity> favNotes;
  final List<NoteEntity> sharedWithMeNotes;
  final List<NoteEntity> trashNotes;

  NotesLoadedState({
    required this.notePageType,
    required this.myNotes,
    required this.favNotes,
    required this.sharedWithMeNotes,
    required this.trashNotes,
  });

  NotesLoadedState copyWith({
    NotePageType? notePageType,
    List<NoteEntity>? myNotes,
    List<NoteEntity>? favNotes,
    List<NoteEntity>? sharedWithMeNotes,
    List<NoteEntity>? trashNotes,
  }) {
    return NotesLoadedState(
      notePageType: notePageType ?? this.notePageType,
      myNotes: myNotes ?? this.myNotes,
      favNotes: favNotes ?? this.favNotes,
      sharedWithMeNotes: sharedWithMeNotes ?? this.sharedWithMeNotes,
      trashNotes: trashNotes ?? this.trashNotes,
    );
  }
}

// Action states
final class NotesActionState extends NotesState {}

final class NewNoteAddSuccessState extends NotesActionState {}

final class NewNoteAddFailedState extends NotesActionState {}

final class UpdateNoteSuccessState extends NotesActionState {}

final class UpdateNoteFailedState extends NotesActionState {}

final class DeleteNoteSuccessState extends NotesActionState {}

final class DeleteNoteFailedState extends NotesActionState {
  final String message;

  DeleteNoteFailedState({required this.message});
}

final class AddToFavouriteSuccessState extends NotesActionState {}

final class AddToFavouriteFailedState extends NotesActionState {}

final class DeleteNoteForeverSuccessState extends NotesActionState {}

final class DeleteNoteForeverFailedState extends NotesActionState {
  final String message;

  DeleteNoteForeverFailedState({required this.message});
}

final class ShareSuccessState extends NotesActionState {}

final class ShareFailedState extends NotesActionState {
  final String message;

  ShareFailedState({required this.message});
}

final class DeleteAllNotesSuccessState extends NotesActionState {
  final String message;

  DeleteAllNotesSuccessState({required this.message});
}

final class DeleteAllNotesFailedState extends NotesActionState {
  final String message;

  DeleteAllNotesFailedState({required this.message});
}
