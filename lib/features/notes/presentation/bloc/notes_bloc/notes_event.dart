part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent {}

final class NotePageInitialEvent extends NotesEvent {}

final class AddNewNoteButtonPressedEvent extends NotesEvent {
  final String noteTitle;
  final String noteContent;

  AddNewNoteButtonPressedEvent({
    required this.noteTitle,
    required this.noteContent,
  });
}
