class NoteEntity {
  final int? noteId;
  final String noteTitle;
  final String noteContent;
  final String? ownerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final bool isPrivate;
  final bool isFavourite;
  final bool isDeleted;
  final List<String> sharedWithUserIds;
  final bool isSynced;

  NoteEntity({
    this.noteId,
    required this.noteTitle,
    required this.noteContent,
    this.ownerId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.isPrivate,
    required this.isFavourite,
    required this.isDeleted,
    required this.sharedWithUserIds,
    required this.isSynced,
  });
}
