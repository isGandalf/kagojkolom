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

final class UpdateNoteButtonPressedEvent extends NotesEvent {
  final int noteId;
  final String noteTitle;
  final String noteContent;
  final DateTime createdAt;
  final bool isPrivate;
  final bool isFavourite;
  final List<String> sharedWithUserIds;

  UpdateNoteButtonPressedEvent({
    required this.noteId,
    required this.noteTitle,
    required this.noteContent,
    required this.createdAt,
    required this.isPrivate,
    required this.isFavourite,
    required this.sharedWithUserIds,
  });
}

final class DeleteNoteButtonPressedEvent extends NotesEvent {
  final int noteId;

  DeleteNoteButtonPressedEvent({required this.noteId});
}
