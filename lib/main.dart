import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/theme/app_theme.dart';
import 'package:kagojkolom/features/auth/data/repository/user_data_repository.dart';
import 'package:kagojkolom/features/auth/data/source/user_auth.dart';
import 'package:kagojkolom/features/auth/domain/usecases/user_usecases.dart';
import 'package:kagojkolom/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:kagojkolom/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:kagojkolom/features/auth/presentation/pages/homepage/homepage_parent.dart';
import 'package:kagojkolom/features/auth/presentation/pages/login/login_parent.dart';
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
              F I R E B A S E (cloud db) - Initialization
  =====================================================================================
  */

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

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
              I S A R (local db) - Initialization
  =====================================================================================
  */

  final directory =
      await getApplicationDocumentsDirectory(); // get local directory path
  final isardb = await Isar.open([
    NoteModelSchema,
  ], directory: directory.path); // assign the path to isar schema

  // Note dependencies
  final notesDataSources = NotesDataSources(db: isardb);
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
      child: KagojKolom(),
    ),
  );
}

class KagojKolom extends StatelessWidget {
  const KagojKolom({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1200;
        return MaterialApp(
          theme: darkTheme,
          debugShowCheckedModeBanner: false,
          home: LoginParent(),
        );
      },
    );
  }
}
