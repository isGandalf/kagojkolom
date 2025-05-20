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
import 'package:kagojkolom/features/user/presentation/bloc/user_bloc.dart';
import 'package:kagojkolom/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  await firebaseAuth.signOut();

  final userAuth = UserAuth(
    firebaseAuth: firebaseAuth,
    firebaseFirestore: firebaseFirestore,
  );
  final userDomainRepository = UserDataRepository(userAuth: userAuth);
  final userDomainUsecases = UserUsecases(
    userDomainRepository: userDomainRepository,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignupBloc(userDomainUsecases)),
        BlocProvider(create: (context) => LoginBloc(userDomainUsecases)),
        BlocProvider(create: (context) => UserBloc()),
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
          home: HomepageParent(),
        );
      },
    );
  }
}
