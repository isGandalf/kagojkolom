// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
// import 'package:kagojkolom/features/notes/presentation/pages/notes/notes_desktop.dart';
// import 'package:kagojkolom/features/notes/presentation/pages/notes/notes_mobile.dart';
// import 'package:kagojkolom/features/notes/presentation/pages/notes/notes_tablet.dart';
// import 'package:kagojkolom/shared/responsive/responsive_layout.dart';

// class NotesParent extends StatelessWidget {
//   const NotesParent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<NotesBloc, NotesState>(
//       listenWhen: (previous, current) => current is NotesActionState,
//       buildWhen: (previous, current) => current is NotesNonActionState,
//       listener: (context, state) {},
//       builder: (context, state) {
//         return const ResponsiveLayout(
//           mobileScaffold: NotesMobile(),
//           tabletScaffold: NotesTablet(),
//           desktopScaffold: NotesDesktop(),
//         );
//       },
//     );
//   }
// }
