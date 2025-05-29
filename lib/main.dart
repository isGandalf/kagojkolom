import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/theme/app_theme.dart';
import 'package:kagojkolom/features/auth/data/model/user_model.dart';
import 'package:kagojkolom/features/auth/data/repository/user_data_repository.dart';
import 'package:kagojkolom/features/auth/data/source/user_auth.dart';
import 'package:kagojkolom/features/auth/domain/usecases/user_usecases.dart';
import 'package:kagojkolom/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:kagojkolom/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:kagojkolom/features/auth/presentation/pages/homepage/homepage_parent.dart';
import 'package:kagojkolom/features/auth/presentation/pages/login/login_parent.dart';
import 'package:kagojkolom/features/auth/presentation/pages/splashscreen/splashscreen_parent.dart';
import 'package:kagojkolom/features/notes/data/models/note_model.dart';
import 'package:kagojkolom/features/notes/data/repository/notes_data_repository.dart';
import 'package:kagojkolom/features/notes/data/sources/notes_data_sources.dart';
import 'package:kagojkolom/features/notes/domain/usecases/notes_usecases.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/user/presentation/bloc/user_bloc.dart';
import 'package:kagojkolom/firebase_options.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*
  =====================================================================================
                                  F I R E B A S E
  =====================================================================================
  */

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // check if user already logged in
  final currentUser = firebaseAuth.currentUser;

  // User auth dependencies
  final userAuth = UserAuth(
    firebaseAuth: firebaseAuth,
    firebaseFirestore: firebaseFirestore,
  );
  final userDomainRepository = UserDataRepository(userAuth: userAuth);
  final userDomainUsecases = UserUsecases(
    userDomainRepository: userDomainRepository,
  );

  /*
  =====================================================================================
                                  F I R E S T O R E
  =====================================================================================
  */

  final notesDataSources = NotesDataSources(
    firebaseAuth: firebaseAuth,
    firebaseFirestore: firebaseFirestore,
  );
  final notesDomainRepository = NotesDataRepositoryImpl(
    notesDataSources: notesDataSources,
  );
  final noteUsecases = NoteUsecases(
    notesDomainRepository: notesDomainRepository,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignupBloc(userDomainUsecases)),
        BlocProvider(create: (context) => LoginBloc(userDomainUsecases)),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => NotesBloc(noteUsecases)),
      ],
      child: KagojKolom(currentUser: currentUser),
    ),
  );
}

class KagojKolom extends StatelessWidget {
  final User? currentUser;
  const KagojKolom({super.key, this.currentUser});

  @override
  Widget build(BuildContext context) {
    final userId = currentUser?.uid;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1200;
        return MaterialApp(
          theme: darkTheme,
          debugShowCheckedModeBanner: false,
          home: currentUser == null ? LoginParent() : SplashscreenParent(),
        );
      },
    );
  }
}
