/*

This class establish if user is already logged in. If yes, then userEntity is fetched from cloud
and passed to Userbloc. If no user found, then it is redirected to Login page.

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/global/logger.dart';
import 'package:kagojkolom/features/auth/data/model/user_model.dart';
import 'package:kagojkolom/features/auth/presentation/pages/homepage/homepage_parent.dart';
import 'package:kagojkolom/features/auth/presentation/pages/login/login_parent.dart';
import 'package:kagojkolom/features/user/presentation/bloc/user_bloc.dart';

class SplashscreenLogic extends StatefulWidget {
  const SplashscreenLogic({super.key});

  @override
  State<SplashscreenLogic> createState() => _SplashscreenLogicState();
}

class _SplashscreenLogicState extends State<SplashscreenLogic> {
  /*
  1. Create instances -
    > FirebaseAuth: To get the current user
    > Firestore: To get the user details
  2. Check if user is null, if yes then return to login page. If not null, then continue
  3. Fetch user details from firestore (snapshot)
  4. Convert to model
  5. Convert to entity
  6. Trigger user bloc event passing the userEntity
  7. Return Homepage
  */

  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _initLoggedInUser();
  }

  Future<void> _initLoggedInUser() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        _goToLogin();
        return;
      }
      final userId = user.uid;

      final userSnapshot =
          await firebaseFirestore.collection('users').doc(userId).get();
      if (!userSnapshot.exists) {
        return _goToLogin();
      }
      final userModel = UserModel.fromJson(userSnapshot.data()!);
      final userEntity = userModel.toEntity();

      if (!mounted) {
        return;
      }
      context.read<UserBloc>().add(LoadUserEvent(userEntity: userEntity));
      _goToHomepage();
    } on FirebaseException catch (e) {
      logger.e('$e');
      _goToLogin();
    } catch (e) {
      logger.e('$e');
      _goToLogin();
    }
  }

  void _goToLogin() {
    if (!mounted) {
      return;
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginParent()),
      (route) => false,
    );
  }

  void _goToHomepage() {
    if (!mounted) {
      return;
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => HomepageParent()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
