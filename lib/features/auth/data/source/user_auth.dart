import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kagojkolom/core/error/user_auth_errors.dart';
import 'package:kagojkolom/core/global/logger.dart';
import 'package:kagojkolom/features/auth/data/model/user_model.dart';

class UserAuth {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  UserAuth({required this.firebaseAuth, required this.firebaseFirestore});

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<Either<UnableToCreateNewUser, void>> createNewUser(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user == null) {
        return Left(UnableToCreateNewUser(message: 'User created is null'));
      }

      await firebaseFirestore.collection('users').doc(user.uid).set({
        'userId': user.uid,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'profilePictureUrl': 'lib/assets/images/2151100221.jpg',
      });

      return Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(
        UnableToCreateNewUser(message: e.message ?? 'Auth error occured.'),
      );
    } catch (e) {
      return Left(UnableToCreateNewUser(message: 'Unexpected error: $e'));
    }
  }

  Future<Either<UnableToLoginUser, UserModel>> loginUser(
    String email,
    String password,
  ) async {
    // login user with email and password
    try {
      final UserCredential result = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // get user
      final user = result.user;

      if (user == null) {
        return Left(UnableToLoginUser(message: 'User not found'));
      }

      // get user details from cloud
      final userDetails =
          await firebaseFirestore.collection('users').doc(user.uid).get();
      final userData = userDetails.data();
      if (userData == null) {
        return Left(UnableToLoginUser(message: 'User details not found'));
      }

      // convert user details to model
      final userModel = UserModel.fromJson(userData);
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left(UnableToLoginUser(message: 'Login failed: ${e.message}'));
    } catch (e) {
      return Left(UnableToLoginUser(message: 'Unexpected failure: $e'));
    }
  }

  Future<Either<UnableToSignOutUser, void>> userSignOut() async {
    try {
      final user = currentUser;
      if (user == null) {
        return Left(UnableToSignOutUser(message: 'No logged in user'));
      }

      await firebaseAuth.signOut();
      logger.d('Logout success for user --> $user');
      return Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(
        UnableToSignOutUser(message: 'Firebase sign out error --> $e'),
      );
    } on Exception catch (e) {
      return Left(
        UnableToSignOutUser(
          message: 'An error occured while signing out --> $e',
        ),
      );
    } catch (e) {
      return Left(
        UnableToSignOutUser(message: 'An unexpected error occured --> $e'),
      );
    }
  }

  Future<Either<UpdateUserDetails, UserModel>> updateUserDetails(
    String firstName,
    String lastName,
    String profilePictureUrl,
  ) async {
    try {
      final user = currentUser;
      if (user == null) {
        return Left(UpdateUserDetails(message: 'No user found'));
      }

      final userSnapshot =
          await firebaseFirestore.collection('users').doc(user.uid).get();
      if (!userSnapshot.exists || userSnapshot.data()!.isEmpty) {
        return Left(UpdateUserDetails(message: 'No user data found'));
      }

      final currentUserDetails = userSnapshot.data()!;

      final Map<String, dynamic> updatedFields = {};
      bool hasChanged = false;

      if (currentUserDetails['firstName'] != firstName) {
        updatedFields['firstName'] = firstName;
        hasChanged = true;
      }
      if (currentUserDetails['lastName'] != lastName) {
        updatedFields['lastName'] = lastName;
        hasChanged = true;
      }
      if (currentUserDetails['profilePictureUrl'] != profilePictureUrl) {
        updatedFields['profilePictureUrl'] = profilePictureUrl;
        hasChanged = true;
      }

      UserModel updatedUserModel;

      if (hasChanged) {
        await firebaseFirestore
            .collection('users')
            .doc(user.uid)
            .update(updatedFields);
        final userSnapshot =
            await firebaseFirestore.collection('users').doc(user.uid).get();
        if (!userSnapshot.exists || userSnapshot.data()!.isEmpty) {
          return Left(UpdateUserDetails(message: 'No user data found'));
        }

        final updatedUserData = userSnapshot.data()!;
        updatedUserModel = UserModel.fromJson(updatedUserData);
      } else {
        updatedUserModel = UserModel.fromJson(currentUserDetails);
      }

      return Right(updatedUserModel);
    } on FirebaseException catch (e) {
      return Left(
        UpdateUserDetails(
          message: 'Firebase exception occured while updating data --> $e',
        ),
      );
    } on Exception catch (e) {
      return Left(
        UpdateUserDetails(
          message: 'An error occured while updating data --> $e',
        ),
      );
    } catch (e) {
      return Left(
        UpdateUserDetails(
          message: 'An unexpected error occurred while updating data --> $e',
        ),
      );
    }
  }
}
