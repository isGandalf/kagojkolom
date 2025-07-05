import 'package:dartz/dartz.dart';
import 'package:kagojkolom/core/error/notes_errors.dart';
import 'package:kagojkolom/features/notes/data/models/note_model.dart';
import 'package:kagojkolom/features/notes/data/sources/notes_data_sources.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/domain/repository/notes_domain_repository.dart';

class NotesDataRepositoryImpl implements NotesDomainRepository {
  final NotesDataSources notesDataSources;

  NotesDataRepositoryImpl({required this.notesDataSources});

  // Fetch
  @override
  Future<Either<NotesErrors, List<NoteEntity>>> fetchNotes() async {
    final result = await notesDataSources.fetchNotes();

    return result.fold(
      (failure) => Left(FetchNotesError(message: failure.toString())),
      (entity) {
        final noteEntity = entity.map((notes) => notes.toEntity()).toList();
        return Right(noteEntity);
      },
    );
  }

  // Add new note
  @override
  Future<Either<NotesErrors, void>> addNewNote(NoteEntity note) async {
    // convert to model
    final noteModel = NoteModel.fromEntity(note);

    // send to data source
    final result = await notesDataSources.addNewNote(noteModel);

    return result.fold(
      (failure) => Left(AddNoteError(message: failure.toString())),
      (_) => Right(null),
    );
  }

  // Update existing note
  @override
  Future<Either<NotesErrors, void>> updateNote(NoteEntity note) async {
    final noteModel = NoteModel.fromEntity(note);
    final result = await notesDataSources.updateNote(noteModel);
    return result.fold(
      (failure) => Left(UpdateNoteError(message: failure.toString())),
      (_) => Right(null),
    );
  }

  // Delete note (move to trash)
  @override
  Future<Either<NotesErrors, void>> deleteNote(int noteId) async {
    final result = await notesDataSources.deleteNote(noteId);
    return result.fold(
      (failure) => Left(DeleteNoteError(message: failure.toString())),
      (_) => Right(null),
    );
  }

  // Add a note to favourite
  @override
  Future<Either<NotesErrors, void>> addToFavourite(int noteId) async {
    final result = await notesDataSources.addToFavourite(noteId);
    return result.fold(
      (failure) => Left(UpdateNoteError(message: failure.toString())),
      (_) => Right(null),
    );
  }

  // Share a note with an email
  @override
  Future<Either<NotesErrors, void>> shareNote(int noteId, String email) async {
    final result = await notesDataSources.shareNote(noteId, email);
    return result.fold(
      (failure) => Left(SharedWithMeError(message: failure.toString())),
      (_) => Right(null),
    );
  }

  // Fetch all notes which are shared with user
  @override
  Future<Either<NotesErrors, List<NoteEntity>>> fetchNotesSharedWithMe() async {
    final result = await notesDataSources.fetchNotesSharedWithMe();
    return result.fold(
      (failure) => Left(SharedWithMeError(message: failure.message)),
      (noteList) {
        final noteListEntity = noteList.map((note) => note.toEntity()).toList();
        return Right(noteListEntity);
      },
    );
  }

  // Delete a note from DB
  @override
  Future<Either<NotesErrors, void>> deleteNoteFromDb(int noteId) async {
    final result = await notesDataSources.deleteNoteFromDb(noteId);
    return result.fold(
      (failure) => Left(DeleteNoteError(message: failure.toString())),
      (_) => Right(null),
    );
  }

  // Delete all notes from db
  @override
  Future<Either<NotesErrors, String>> deleteAllNotes() async {
    final result = await notesDataSources.deleteAllNotes();
    return result.fold(
      (failure) => Left(DeleteNoteError(message: failure.message)),
      (message) => Right(message),
    );
  }
}
