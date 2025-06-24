// import 'package:flutter/material.dart';
// import 'package:kagojkolom/core/theme/app_colors_common.dart';
// import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
// import 'package:kagojkolom/features/notes/presentation/widgets/three_dot_menu.dart';

// class MiddleColumnNoteList extends StatelessWidget {
//   const MiddleColumnNoteList({
//     super.key,
//     required this.noteEntityList,
//     required this.selectedNote,
//     required this.onSelect,
//   });

//   final List<NoteEntity> noteEntityList;
//   final NoteEntity? selectedNote;
//   final void Function(NoteEntity) onSelect;

//   void sortNoteList(List<NoteEntity> noteList) {
//     noteList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
//   }

//   @override
//   Widget build(BuildContext context) {
//     sortNoteList(noteEntityList);
//     return ListView.builder(
//       itemCount: noteEntityList.length,
//       itemBuilder: (context, index) {
//         final note = noteEntityList[index];
//         return Column(
//           children: [
//             InkWell(
//               onTap: () => onSelect(note),
//               hoverColor: const Color.fromARGB(22, 96, 125, 139),
//               splashColor: const Color.fromARGB(21, 96, 125, 139),
//               child: Container(
//                 height: 100,
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 color:
//                     selectedNote == note
//                         ? AppColorsCommon.primaryBlue
//                         : Colors.transparent,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // -- note details
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             note.noteTitle,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           SizedBox(height: 6),
//                           Text(
//                             note.noteContent,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // -- note options
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         ThreeDotMenu(noteId: note.noteId),
//                         Icon(Icons.favorite),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Divider(thickness: 1, height: 0),
//           ],
//         );
//       },
//     );
//   }
// }
