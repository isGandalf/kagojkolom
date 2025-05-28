import 'package:dartz/dartz.dart';
import 'package:kagojkolom/core/error/notes_errors.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/domain/repository/notes_domain_repository.dart';

class NoteUsecases {
  final NotesDomainRepository notesDomainRepository;

  NoteUsecases({required this.notesDomainRepository});

  // Fetch all notes
  Future<Either<NotesErrors, List<NoteEntity>>> fetchNotesFromLocal() async {
    final result = await notesDomainRepository.fetchNotesFromLocal();
    return result.fold(
      (failure) => Left(FetchLocalNotesError(message: failure.toString())),
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
    );

    final result = await notesDomainRepository.addNewNote(noteEntity);
    return result.fold(
      (failure) => Left(AddNoteToLocalError(message: failure.toString())),
      (_) => Right(null),
    );
  }

  // update existing note
  Future<Either<NotesErrors, void>> updateNote(NoteEntity note) async {
    final result = await notesDomainRepository.updateNote(note);
    return result.fold(
      (failure) => Left(UpdateNoteToLocalError(message: failure.toString())),
      (_) => Right(null),
    );
  }

  // Delete note
  Future<Either<NotesErrors, void>> deleteNote(int noteId) async {
    final result = await notesDomainRepository.deleteNote(noteId);
    return result.fold(
      (failure) => Left(DeleteNoteFromLocalError(message: failure.toString())),
      (_) => Right(null),
    );
  }
}
