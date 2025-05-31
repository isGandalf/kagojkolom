import 'package:dartz/dartz.dart';
import 'package:kagojkolom/core/error/notes_errors.dart';
import 'package:kagojkolom/core/global/logger.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/domain/repository/notes_domain_repository.dart';

class NoteUsecases {
  final NotesDomainRepository notesDomainRepository;

  NoteUsecases({required this.notesDomainRepository});

  // Fetch all notes
  Future<Either<NotesErrors, List<NoteEntity>>> fetchNotes() async {
    final result = await notesDomainRepository.fetchNotes();
    return result.fold(
      (failure) => Left(FetchNotesError(message: failure.toString())),
      (entity) => Right(entity),
    );
  }

  // add new note
  Future<Either<NotesErrors, void>> addNewNote(
    String noteTitle,
    String noteContent,
  ) async {
    // creates note entity with defaults.
    final noteEntity = NoteEntity(
      noteTitle: noteTitle,
      noteContent: noteContent,
      isPrivate: false,
      isFavourite: false,
      isDeleted: false,
      sharedWithUserIds: [],
      isSynced: false,
      noteId: DateTime.now().millisecondsSinceEpoch,
      createdAt: DateTime.now(),
    );

    final result = await notesDomainRepository.addNewNote(noteEntity);
    return result.fold(
      (failure) => Left(AddNoteError(message: failure.toString())),
      (_) => Right(null),
    );
  }

  // update existing note
  Future<Either<NotesErrors, void>> updateNote(
    int noteId,
    String noteTitle,
    String noteContent,
    DateTime createdAt,
    bool isPrivate,
    bool isFavourite,
    List<String> sharedWithUserIds,
  ) async {
    logger.d('From use case --> $noteTitle -- $noteContent');
    // create note entity
    final noteEntity = NoteEntity(
      noteId: noteId,
      noteTitle: noteTitle,
      noteContent: noteContent,
      createdAt: createdAt,
      isPrivate: isPrivate,
      isFavourite: isFavourite,
      isDeleted: false,
      sharedWithUserIds: sharedWithUserIds,
      isSynced: false,
      updatedAt: DateTime.now(),
    );

    final result = await notesDomainRepository.updateNote(noteEntity);
    return result.fold(
      (failure) => Left(UpdateNoteError(message: failure.toString())),
      (_) => Right(null),
    );
  }

  // Delete note
  Future<Either<NotesErrors, void>> deleteNote(int noteId) async {
    final result = await notesDomainRepository.deleteNote(noteId);
    return result.fold(
      (failure) => Left(DeleteNoteError(message: failure.toString())),
      (_) => Right(null),
    );
  }
}
