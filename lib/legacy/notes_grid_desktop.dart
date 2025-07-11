// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
// import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_card.dart';
// import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_page_type.dart';

// class NotesGridDesktop extends StatelessWidget {
//   final List<NoteEntity> noteList;
//   final NotePageType notePageType;
//   const NotesGridDesktop({
//     super.key,
//     required this.noteList,
//     required this.notePageType,
//   });

//   void sortedList(List<NoteEntity> noteList) {
//     noteList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final crossAxis = MediaQuery.of(context).size.width ~/ 300;
//     sortedList(noteList);
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 100.0,
//         vertical: 20,
//       ),
//       child: MasonryGridView.builder(
//         gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: crossAxis,
//           //childAspectRatio: 500 / 600,
//         ),
//         itemCount: noteList.length,
//         itemBuilder: (context, index) {
//           final note = noteList[index];
//           return NoteCard(
//             note: note,
//             notePageType: notePageType,
//             key: ValueKey(note.noteId),
//           );
//         },
//       ),
//     );
//   }
// }
