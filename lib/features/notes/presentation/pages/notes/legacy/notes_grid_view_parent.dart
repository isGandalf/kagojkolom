// import 'package:flutter/material.dart';
// import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
// import 'package:kagojkolom/features/notes/presentation/pages/notes/mobile/notes_grid_desktop.dart';
// import 'package:kagojkolom/features/notes/presentation/pages/notes/mobile/notes_grid_mobile.dart';
// import 'package:kagojkolom/features/notes/presentation/pages/notes/mobile/notes_grid_tablet.dart';
// import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_page_type.dart';
// import 'package:kagojkolom/shared/responsive/responsive_layout.dart';

// class NotesGridViewParent extends StatelessWidget {
//   final List<NoteEntity> noteList;
//   final NotePageType notePageType;
//   const NotesGridViewParent({
//     super.key,
//     required this.noteList,
//     required this.notePageType,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveLayout(
//       mobileScaffold: NotesGridMobile(
//         noteList: noteList,
//         notePageType: notePageType,
//       ),
//       tabletScaffold: NotesGridTablet(
//         noteList: noteList,
//         notePageType: notePageType,
//       ),
//       desktopScaffold: NotesGridDesktop(
//         noteList: noteList,
//         notePageType: notePageType,
//       ),
//     );
//   }
// }
