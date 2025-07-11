// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
// import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_card.dart';
// import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_page_type.dart';

// class NotesGridMobile extends StatelessWidget {
//   final List<NoteEntity> noteList;
//   final NotePageType notePageType;
//   const NotesGridMobile({
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
//     return Column(
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 //SizedBox(height: 10),
//                 Text(
//                   '   ${noteList.length} notes',
//                   style: TextStyle(color: Colors.blueGrey),
//                 ),
//                 //SizedBox(height: 10),
//                 Expanded(
//                   child: MasonryGridView.builder(
//                     gridDelegate:
//                         SliverSimpleGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: crossAxis,
//                           //childAspectRatio: 500 / 600,
//                         ),
//                     itemCount: noteList.length,
//                     itemBuilder: (context, index) {
//                       final note = noteList[index];
//                       return NoteCard(
//                         note: note,
//                         notePageType: notePageType,
//                         key: ValueKey(note.noteId),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
