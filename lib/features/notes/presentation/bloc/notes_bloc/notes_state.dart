part of 'notes_bloc.dart';

@immutable
sealed class NotesState {}

final class NotesInitial extends NotesState {}

// Non-action states
final class NotesNonActionState extends NotesState {}

final class NotesLoadingState extends NotesNonActionState {}

final class NotesLoadingFailedState extends NotesNonActionState {}

final class NotesLoadedState extends NotesNonActionState {
  final List<NoteEntity> allNotes;

  NotesLoadedState({required this.allNotes});
}

// Action states
final class NotesActionState extends NotesState {}

final class NewNoteAddSuccessState extends NotesActionState {}

final class NewNoteAddFailedState extends NotesActionState {}

final class UpdateNoteSuccessState extends NotesActionState {}

final class UpdateNoteFailedState extends NotesActionState {}
