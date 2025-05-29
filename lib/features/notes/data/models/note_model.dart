/*

UI (user input)  -->  Entity  -->  Model  -->  Isar DB (save)
Isar DB (fetch)  -->  Model  -->  Entity  -->  UI (display)


*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';

class NoteModel {
  final int noteId;
  final String noteTitle;
  final String noteContent;
  final String? ownerId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final bool isPrivate;
  final bool isFavourite;
  final bool isDeleted;
  final List<String> sharedWithUserIds;
  final bool isSynced;

  NoteModel({
    required this.noteId,
    required this.noteTitle,
    required this.noteContent,
    this.ownerId,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.isPrivate,
    required this.isFavourite,
    required this.isDeleted,
    required this.sharedWithUserIds,
    required this.isSynced,
  });

  // model to entity
  NoteEntity toEntity() {
    return NoteEntity(
      noteId: noteId,
      noteTitle: noteTitle,
      noteContent: noteContent,
      createdAt: createdAt,
      isPrivate: isPrivate,
      isFavourite: isFavourite,
      isDeleted: isDeleted,
      sharedWithUserIds: sharedWithUserIds,
      isSynced: isSynced,
      deletedAt: deletedAt,
      updatedAt: updatedAt,
      ownerId: ownerId,
    );
  }

  // entity to model
  factory NoteModel.fromEntity(NoteEntity entity) {
    return NoteModel(
      noteId: entity.noteId,
      noteTitle: entity.noteTitle,
      noteContent: entity.noteContent,
      createdAt: entity.createdAt,
      isPrivate: entity.isPrivate,
      isFavourite: entity.isFavourite,
      isDeleted: entity.isDeleted,
      deletedAt: entity.deletedAt,
      updatedAt: entity.updatedAt,
      ownerId: entity.ownerId,
      sharedWithUserIds: entity.sharedWithUserIds,
      isSynced: entity.isSynced,
    );
  }

  // from json
  factory NoteModel.fromJson(Map<String, dynamic> jsonData) {
    // converion safety fields
    final createdAt = (jsonData['createdAt'] as Timestamp).toDate();
    final updatedAt =
        jsonData['updatedAt'] != null
            ? (jsonData['updatedAt'] as Timestamp).toDate()
            : null;
    final deletedAt =
        jsonData['deletedAt'] != null
            ? (jsonData['deletedAt'] as Timestamp).toDate()
            : null;

    final sharedWithUserIds = List<String>.from(
      jsonData['sharedWithUserIds'] ?? [],
    );

    return NoteModel(
      noteId: jsonData['noteId'],
      noteTitle: jsonData['noteTitle'],
      noteContent: jsonData['noteContent'],
      createdAt: createdAt,
      ownerId: jsonData['ownerId'],
      isPrivate: jsonData['isPrivate'],
      isFavourite: jsonData['isFavourite'],
      isDeleted: jsonData['isDeleted'],
      deletedAt: deletedAt,
      updatedAt: updatedAt,
      sharedWithUserIds: sharedWithUserIds,
      isSynced: jsonData['isSynced'],
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    final createdTimestamp = Timestamp.fromDate(createdAt);
    final updatedTimestamp =
        updatedAt != null ? Timestamp.fromDate(updatedAt!) : null;
    final deletedTimestamp =
        deletedAt != null ? Timestamp.fromDate(deletedAt!) : null;

    return {
      'noteId': noteId,
      'noteTitle': noteTitle,
      'noteContent': noteContent,
      'createdAt': createdTimestamp,
      'ownerId': ownerId,
      'isPrivate': isPrivate,
      'isFavourite': isFavourite,
      'isDeleted': isDeleted,
      'deletedAt': deletedTimestamp,
      'updatedAt': updatedTimestamp,
      'sharedWithUserIds': sharedWithUserIds,
      'isSynced': isSynced,
    };
  }

  NoteModel copyWith({String? ownerId}) {
    return NoteModel(
      noteId: noteId,
      noteTitle: noteTitle,
      noteContent: noteContent,
      createdAt: createdAt,
      ownerId: ownerId ?? this.ownerId,
      isPrivate: isPrivate,
      isFavourite: isFavourite,
      isDeleted: isDeleted,
      deletedAt: deletedAt,
      updatedAt: updatedAt,
      sharedWithUserIds: sharedWithUserIds,
      isSynced: isSynced,
    );
  }
}
