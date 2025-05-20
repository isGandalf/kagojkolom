import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';

extension NoteEntityCopyWith on NoteEntity {
  NoteEntity copyWith({
    String? noteTitle,
    String? noteContent,
    DateTime? updatedAt,
    DateTime? deletedAt,
    bool? isPrivate,
    bool? isFavourite,
    bool? isDeleted,
    List<String>? sharedWithUserIds,
  }) {
    return NoteEntity(
      noteId: noteId,
      noteTitle: noteTitle ?? this.noteTitle,
      noteContent: noteContent ?? this.noteContent,
      ownerId: ownerId,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      isPrivate: isPrivate ?? this.isPrivate,
      isFavourite: isFavourite ?? this.isFavourite,
      isDeleted: isDeleted ?? this.isDeleted,
      sharedWithUserIds: sharedWithUserIds ?? this.sharedWithUserIds,
    );
  }
}
