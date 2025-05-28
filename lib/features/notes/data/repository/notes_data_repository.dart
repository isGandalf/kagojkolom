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
  Future<Either<NotesErrors, List<NoteEntity>>> fetchNotesFromLocal() async {
    final result = await notesDataSources.fetchNotesFromLocal();

    return result.fold(
      (failure) => Left(FetchLocalNotesError(message: failure.toString())),
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
      (failure) => Left(AddNoteToLocalError(message: failure.toString())),
      (_) => Right(null),
    );
  }

  // Update existing note
  @override
  Future<Either<NotesErrors, void>> updateNote(NoteEntity note) async {
    final noteModel = NoteModel.fromEntity(note);
    final result = await notesDataSources.updateNote(noteModel);
    return result.fold(
      (failure) => Left(UpdateNoteToLocalError(message: failure.toString())),
      (_) => Right(null),
    );
  }

  // Delete note
  @override
  Future<Either<NotesErrors, void>> deleteNote(int noteId) async {
    final result = await notesDataSources.deleteNote(noteId);
    return result.fold(
      (failure) => Left(DeleteNoteFromLocalError(message: failure.toString())),
      (_) => Right(null),
    );
  }
}
