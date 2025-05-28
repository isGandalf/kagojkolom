import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kagojkolom/core/error/user_auth_errors.dart';
import 'package:kagojkolom/features/auth/data/model/user_model.dart';

class UserAuth {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  UserAuth({required this.firebaseAuth, required this.firebaseFirestore});

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
}
