part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent {}

final class NotePageInitialEvent extends NotesEvent {
  final NotePageType notePageType;

  NotePageInitialEvent({required this.notePageType});
}

final class NotePageOptionPressedEvent extends NotesEvent {
  final NotePageType selectedNotePage;

  NotePageOptionPressedEvent({required this.selectedNotePage});
}

final class AddNewNoteButtonPressedEvent extends NotesEvent {
  final String noteTitle;
  final String noteContent;
  final NotePageType notePageType;

  AddNewNoteButtonPressedEvent({
    required this.noteTitle,
    required this.noteContent,
    required this.notePageType,
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
  final NotePageType notePageType;

  UpdateNoteButtonPressedEvent({
    required this.noteId,
    required this.noteTitle,
    required this.noteContent,
    required this.createdAt,
    required this.isPrivate,
    required this.isFavourite,
    required this.sharedWithUserIds,
    required this.notePageType,
  });
}

final class DeleteNoteButtonPressedEvent extends NotesEvent {
  final int noteId;
  final NotePageType notePageType;

  DeleteNoteButtonPressedEvent({
    required this.noteId,
    required this.notePageType,
  });
}

final class DeleteNoteForeverButtonPressedEvent extends NotesEvent {
  final int noteId;
  final NotePageType notePageType;

  DeleteNoteForeverButtonPressedEvent({
    required this.noteId,
    required this.notePageType,
  });
}

final class FavouriteButtonPressedEvent extends NotesEvent {
  final int noteId;
  final NotePageType notePageType;

  FavouriteButtonPressedEvent({
    required this.noteId,
    required this.notePageType,
  });
}

final class ShareButtonPressedEvent extends NotesEvent {
  final int noteId;
  final String email;

  ShareButtonPressedEvent({required this.noteId, required this.email});
}
