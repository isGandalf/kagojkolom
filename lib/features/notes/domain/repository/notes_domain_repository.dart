import 'package:dartz/dartz.dart';
import 'package:kagojkolom/core/error/notes_errors.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';

abstract interface class NotesDomainRepository {
  Future<Either<NotesErrors, List<NoteEntity>>> fetchNotes();
  Future<Either<NotesErrors, void>> addNewNote(NoteEntity note);
  Future<Either<NotesErrors, void>> updateNote(NoteEntity note);
  Future<Either<NotesErrors, void>> deleteNote(int noteId);
  Future<Either<NotesErrors, void>> addToFavourite(int noteId);
}
