import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:isar/isar.dart';
import 'package:kagojkolom/core/error/notes_errors.dart';
import 'package:kagojkolom/features/notes/data/models/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesDataSources {
  final Isar db;

  NotesDataSources({required this.db});

  User? get currentUser {
    return FirebaseAuth.instance.currentUser;
  }

  // CRUD Operations below on local db.
  // ==========================================
  // Fetch notes from local
  Future<Either<NotesErrors, List<NoteModel>>> fetchNotesFromLocal() async {
    /*

    1. Fetch notes only when user is logged in.
    2. Extract the user id of the logged in user.
    3. Query local db to fetch the notes by user id.
    4. return the list model.

    */
    try {
      final User? user = currentUser;
      if (user == null) {
        return Left(FetchLocalNotesError(message: 'No user found'));
      }

      final String userId = user.uid;
      final List<NoteModel> noteList =
          await db.noteModels.filter().ownerIdEqualTo(userId).findAll();

      return Right(noteList);
    } on Exception catch (e) {
      return Left(
        FetchLocalNotesError(
          message: 'Fetching notes from local failed --> $e',
        ),
      );
    } catch (e) {
      return Left(
        FetchLocalNotesError(
          message:
              'An unexpected error occured when fetching notes from local storage.',
        ),
      );
    }
  }

  // Save new note to local
  Future<Either<NotesErrors, void>> addNewNote(NoteModel note) async {
    /*
    
    1. Get note object from UI
    2. Add owner id and created date
    3. Write to db

    */

    try {
      final User? user = currentUser;
      if (user == null) {
        return Left(AddNoteToLocalError(message: 'No user found'));
      }

      // get the current user Id and assign to the note object
      final String userId = user.uid;
      note.ownerId = userId;

      // set created at
      note.createdAt = DateTime.now();

      // insert note object to local
      await db.writeTxn(() async {
        await db.noteModels.put(note);
      });

      return Right(null);
    } on Exception catch (e) {
      return Left(
        AddNoteToLocalError(message: 'Failed to add new note to local --> $e'),
      );
    } catch (e) {
      return Left(
        AddNoteToLocalError(
          message:
              'An unexpected error occured when adding new note to local --> $e',
        ),
      );
    }
  }

  // Update existing note to local
  Future<Either<NotesErrors, void>> updateNote(NoteModel note) async {
    /*

    (similar to add note. Isar db manages update entry internally)
    Note: Set updated date and change isSynced flag to false.
    
    */

    try {
      final User? user = currentUser;
      if (user == null) {
        return Left(UpdateNoteToLocalError(message: 'No user found'));
      }

      final userId = user.uid;

      // check if current note is legally edited/updated
      bool noteLegalCheck =
          note.sharedWithUserIds.contains(userId) || note.ownerId == userId;

      if (!noteLegalCheck) {
        return Left(UpdateNoteToLocalError(message: 'Unauthorised update'));
      }

      // add the time when note was updated
      note.updatedAt = DateTime.now();

      // change isSynced flag
      note.isSynced = false;

      await db.writeTxn(() async {
        await db.noteModels.put(note);
      });

      return Right(null);
    } on Exception catch (e) {
      return Left(
        UpdateNoteToLocalError(
          message: 'Failed to update the note to local --> $e',
        ),
      );
    } catch (e) {
      return Left(
        UpdateNoteToLocalError(
          message:
              'An unexpected error occured when updating the note to local --> $e',
        ),
      );
    }
  }

  // delete note from local
  Future<Either<NotesErrors, void>> deleteNote(int noteId) async {
    try {
      final User? user = currentUser;

      if (user == null) {
        return Left(DeleteNoteFromLocalError(message: 'No user found'));
      }

      final note = await db.noteModels.get(noteId);

      if (note == null) {
        return Left(
          DeleteNoteFromLocalError(
            message: 'No note found with the id --> $noteId',
          ),
        );
      }

      note.deletedAt = DateTime.now();
      note.isDeleted = true;
      note.isSynced = false;

      return Right(null);
    } on Exception catch (e) {
      return Left(
        DeleteNoteFromLocalError(
          message: 'Failed to delete note from local --> $e',
        ),
      );
    } catch (e) {
      return Left(
        DeleteNoteFromLocalError(
          message:
              'An unexpected error occured when deleting the note from local --> $e',
        ),
      );
    }
  }

  // helper function to delete a note after 30 days.
  Future<void> permanentDelete(Isar db, String userId) async {
    try {
      final now = DateTime.now();
      final thresholdDate = now.subtract(Duration(days: 30));

      final noteList =
          await db.noteModels
              .filter()
              .isDeletedEqualTo(true)
              .deletedAtLessThan(thresholdDate)
              .ownerIdEqualTo(userId)
              .findAll();

      if (noteList.isEmpty) {
        return;
      }

      final idsToDelete = noteList.map((note) => note.noteId).toList();
      await db.noteModels.deleteAll(idsToDelete);
      return;
    } on Exception catch (e) {
      debugPrint('Deleting notes after 30 days failed --> $e');
    }
  }

  // function to ensure permanent delete runs once a day
  Future<void> runCleanUp(Isar db) async {
    /*

    (Ensure we have a user logged in)
    1. Use local storage to store the last cleanup date-time.
    2. If found null, that means app has been newly installed or user cleared data.
    3. If not null, then find the difference between current time and last cleanup time < 24 hours.
    4. If yes, return and ensure first run is executed in case app is newly installed which will set the cleanup time.
    5. If no, which means last cleanup was > 24 hours, then run permanent delete.
    6. Update current cleanup time.

    */

    // Ensure user logged in
    try {
      final User? user = currentUser;
      if (user == null) {
        return;
      }
      final String userId = user.uid;

      final DateTime now = DateTime.now();

      // local storage instance
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // get last cleanup timestamp
      final int? lastCleanUpDateTime = prefs.getInt('lastCleanUp');

      // if last cleanup is not null then check if 24 hours have crossed
      if (lastCleanUpDateTime != null) {
        final DateTime lastCleanUpTimeConvertedToMillis =
            DateTime.fromMillisecondsSinceEpoch(lastCleanUpDateTime);
        final Duration difference = now.difference(
          lastCleanUpTimeConvertedToMillis,
        );
        // if 24 hours not crossed then return
        if (difference.inHours < 24) {
          return;
        }
      }

      // ensures first run and sets the cleanup time
      await permanentDelete(db, userId);
      await prefs.setInt('lastCleanUp', now.millisecondsSinceEpoch);
    } on Exception catch (e) {
      debugPrint('Unexpected error occured when deleting a note --> $e');
    }
  }
}
