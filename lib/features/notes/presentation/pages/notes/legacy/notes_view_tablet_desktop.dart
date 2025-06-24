// import 'package:flutter/material.dart';
// import 'package:kagojkolom/core/theme/app_colors_dark.dart';
// import 'package:kagojkolom/core/theme/app_colors_light.dart';
// import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';

// class NotesViewTabletDesktop extends StatelessWidget {
//   const NotesViewTabletDesktop({super.key, required this.selectedNote});

//   final NoteEntity? selectedNote;

//   @override
//   Widget build(BuildContext context) {
//     // final String noteTitle = selectedNote?['title'];
//     // final String noteContent = selectedNote?['content'];
//     final noteTitleController = TextEditingController(
//       text: selectedNote?.noteTitle,
//     );
//     final noteContentController = TextEditingController(
//       text: selectedNote?.noteContent,
//     );

//     return Expanded(
//       child: Container(
//         decoration: BoxDecoration(
//           color:
//               Theme.of(context).brightness == Brightness.dark
//                   ? AppColorsDark.noteBackgroundColor
//                   : AppColorsLight.noteBackgroundColor,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
//           child:
//               selectedNote != null
//                   ? Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       //title
//                       SizedBox(
//                         width: double.infinity,
//                         child: TextField(
//                           controller: noteTitleController,
//                           style: TextStyle(
//                             fontSize: 30,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),
//                       //content
//                       Expanded(
//                         child: TextField(
//                           textAlign: TextAlign.start,
//                           controller: noteContentController,
//                           keyboardType: TextInputType.multiline,
//                           maxLines: null,
//                         ),
//                       ),
//                     ],
//                   )
//                   : Center(child: Text('Select a note to view')),
//         ),
//       ),
//     );
//   }
// }
