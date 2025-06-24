/*

This class will handle cloud data manipulation like all CRUD functions.

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kagojkolom/core/error/notes_errors.dart';
import 'package:kagojkolom/features/notes/data/models/note_model.dart';

class NotesDataSources {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  NotesDataSources({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  User? get currentUser {
    return FirebaseAuth.instance.currentUser;
  }

  // ====================================
  //         C R U D operations
  // ====================================

  // ----> NOTE: All operations below should call 'Read' after execution is completed.
  //             This will be handled in statemanagement using bloc.

  // CREATE, a new note and add it to db
  Future<Either<NotesErrors, void>> addNewNote(NoteModel noteModel) async {
    // get current user
    try {
      final user = currentUser;

      // if null, return
      if (user == null) {
        return Left(AddNoteError(message: 'No user found'));
      }

      // get userId
      final userId = user.uid;

      // assign ownerId to note
      final updatedNoteModel = noteModel.copyWith(ownerId: userId);

      // convert noteModel to json
      final noteJson = updatedNoteModel.toJson();

      // get noteId
      final noteId = noteModel.noteId;

      // assign to db
      await firebaseFirestore
          .collection('notes')
          .doc(noteId.toString())
          .set(noteJson);

      return Right(null);
    } on FirebaseException catch (e) {
      return Left(
        AddNoteError(
          message: 'Firebase exception occured while creating new note --> $e',
        ),
      );
    } on Exception catch (e) {
      return Left(
        AddNoteError(
          message: 'Exception occured while creating new note --> $e',
        ),
      );
    } catch (e) {
      return Left(
        AddNoteError(
          message: 'An unexpected error occured while creating new note --> $e',
        ),
      );
    }
  }

  // READ, all notes from db
  Future<Either<NotesErrors, List<NoteModel>>> fetchNotes() async {
    try {
      final user = currentUser;
      if (user == null) {
        return Left(FetchNotesError(message: 'No user found'));
      }

      final userId = user.uid;

      // get list of docs (note object) from firestore
      final notesSnapshot =
          await firebaseFirestore
              .collection('notes')
              .where('ownerId', isEqualTo: userId)
              .get();

      if (notesSnapshot.docs.isEmpty) {
        return Right([]);
      }

      /*
    1. QuerySnapshot (list) received from firestore
    2. Convert each list item to NoteModel
    3. Return as a list
    */
      final noteList =
          notesSnapshot.docs.map((eachNoteSnapshot) {
            return NoteModel.fromJson(eachNoteSnapshot.data());
          }).toList();

      return Right(noteList);
    } on FirebaseException catch (e) {
      return Left(
        FetchNotesError(message: 'Failed to fetch notes from cloud --> $e'),
      );
    } on Exception catch (e) {
      return Left(
        FetchNotesError(message: 'Error occured when fetching notes --> $e'),
      );
    } catch (e) {
      return Left(
        FetchNotesError(
          message: 'An unexpected error occured while fetching notes --> $e',
        ),
      );
    }
  }

  // UPDATE, existing note and write to db
  Future<Either<NotesErrors, void>> updateNote(NoteModel noteModel) async {
    try {
      final user = currentUser;
      if (user == null) {
        return Left(UpdateNoteError(message: 'No user found'));
      }

      // since i am using '.set()', owner id need to be reassigned.
      final userId = user.uid;
      //print('Owner id --> $userId');
      final updatedNoteModel = noteModel.copyWith(ownerId: userId);

      // get noteId
      final noteId = noteModel.noteId;

      // convert to json
      final noteJson = updatedNoteModel.toJson();
      //print(noteJson);

      // update db
      await firebaseFirestore
          .collection('notes')
          .doc(noteId.toString())
          .set(noteJson);

      return Right(null);
    } on FirebaseException catch (e) {
      return Left(
        UpdateNoteError(
          message: 'Firebase exception occured while updating note --> $e',
        ),
      );
    } on Exception catch (e) {
      return Left(
        UpdateNoteError(message: 'Error occured while updating note --> $e'),
      );
    } catch (e) {
      return Left(
        UpdateNoteError(
          message: 'An unexpected error occured while updating note --> $e',
        ),
      );
    }
  }

  // DELETE, a note from db
  Future<Either<NotesErrors, void>> deleteNote(int id) async {
    try {
      final user = currentUser;
      if (user == null) {
        return Left(DeleteNoteError(message: 'No user found'));
      }

      final now = Timestamp.fromDate(DateTime.now());

      await firebaseFirestore.collection('notes').doc(id.toString()).update({
        'isDeleted': true,
        'deletedAt': now,
      });
      //await firebaseFirestore.collection('notes').doc(id.toString()).delete();
      return Right(null);
    } on FirebaseException catch (e) {
      return Left(
        DeleteNoteError(
          message: 'Firebase error occured when deleting note --> $e',
        ),
      );
    } on Exception catch (e) {
      return Left(
        DeleteNoteError(message: 'An error occured when deleting note --> $e'),
      );
    } catch (e) {
      return Left(
        DeleteNoteError(
          message: 'An unexpected error occured when deleting note --> $e',
        ),
      );
    }
  }

  // fetch list of favourite notes
  Future<Either<NotesErrors, List<NoteModel>>> fetchFavouriteNotes() async {
    try {
      final user = currentUser;
      if (user == null) {
        return Left(FetchNotesError(message: 'No user found'));
      }

      final userId = user.uid;
      final snapShotList =
          await firebaseFirestore
              .collection('notes')
              .where('isFavourite', isEqualTo: true)
              .where('ownerId', isEqualTo: userId)
              .get();

      if (snapShotList.docs.isEmpty) {
        return Right([]);
      }

      final favNoteList =
          snapShotList.docs
              .map((eachNote) => NoteModel.fromJson(eachNote.data()))
              .toList();

      return Right(favNoteList);
    } on FirebaseException catch (e) {
      return Left(
        FetchNotesError(
          message: 'Firebase error occured when fetching fav notes --> $e',
        ),
      );
    } on Exception catch (e) {
      return Left(
        FetchNotesError(
          message: 'An error occured while fetching fav notes --> $e',
        ),
      );
    } catch (e) {
      return Left(
        FetchNotesError(message: 'An unexpected error occured --> $e'),
      );
    }
  }

  // Add to favourite
  Future<Either<NotesErrors, void>> addToFavourite(int noteId) async {
    try {
      final user = currentUser;
      if (user == null) {
        return Left(UpdateNoteError(message: 'No user found'));
      }

      //final userId = user.uid;
      final noteSnapshot =
          await firebaseFirestore
              .collection('notes')
              .doc(noteId.toString())
              .get();

      if (noteSnapshot.exists) {
        final note = NoteModel.fromJson(noteSnapshot.data()!);
        await firebaseFirestore
            .collection('notes')
            .doc(noteId.toString())
            .update({'isFavourite': !note.isFavourite});
        print('fav - success');
        return Right(null);
      } else {
        return Left(UpdateNoteError(message: 'No note found with --> $noteId'));
      }
    } on FirebaseException catch (e) {
      return Left(
        UpdateNoteError(
          message: 'Firebase error occured when updating favourite --> $e',
        ),
      );
    } on Exception catch (e) {
      return Left(
        UpdateNoteError(
          message: 'An error occured when updaing favourite --> $e',
        ),
      );
    } catch (e) {
      return Left(
        UpdateNoteError(message: 'An unexpected error occured --> $e'),
      );
    }
  }
}
