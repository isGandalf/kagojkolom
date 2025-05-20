/*

UI (user input)  -->  Entity  -->  Model  -->  Isar DB (save)
Isar DB (fetch)  -->  Model  -->  Entity  -->  UI (display)


*/
import 'package:isar/isar.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';

// run: dart run build_runner build --delete-conflicting-outputs
// note: --delete-conflicting-outputs is added to ensure any previous builds are deleted before creating a new one

part 'note_model.g.dart';

@collection
class NoteModel {
  Id noteId = Isar.autoIncrement;
  late String noteTitle;
  late String noteContent;
  late String ownerId;
  late DateTime createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  late bool isDeleted;
  late bool isPrivate;
  late bool isFavourite;
  late List<String> sharedWithUserIds;

  NoteModel();

  // convert model to entity
  NoteEntity toEntity() {
    return NoteEntity(
      noteId: noteId,
      noteTitle: noteTitle,
      noteContent: noteContent,
      ownerId: ownerId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      isPrivate: isPrivate,
      isFavourite: isFavourite,
      isDeleted: isDeleted,
      sharedWithUserIds: sharedWithUserIds,
    );
  }

  // convert from entity to Model
  factory NoteModel.fromEntity(NoteEntity note) {
    final model = NoteModel();
    model.noteId = note.noteId;
    model.noteTitle = note.noteTitle;
    model.noteContent = note.noteContent;
    model.ownerId = note.ownerId;
    model.createdAt = note.createdAt;
    model.updatedAt = note.updatedAt;
    model.deletedAt = note.deletedAt;
    model.isDeleted = note.isDeleted;
    model.isPrivate = note.isPrivate;
    model.isFavourite = note.isFavourite;
    model.sharedWithUserIds = note.sharedWithUserIds;
    return model;
  }
}
