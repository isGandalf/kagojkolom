// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
// import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_page_type.dart';
// import 'package:kagojkolom/features/notes/presentation/widgets/new_note/button_for_new_note.dart';

// class TabletDesktopAddNoteDialogBox extends StatelessWidget {
//   const TabletDesktopAddNoteDialogBox({
//     super.key,
//     required TextEditingController noteTitleController,
//     required TextEditingController noteContentController,
//   }) : _noteTitleController = noteTitleController,
//        _noteContentController = noteContentController;

//   final TextEditingController _noteTitleController;
//   final TextEditingController _noteContentController;

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       insetPadding: EdgeInsets.zero,
//       child: Container(
//         height: MediaQuery.of(context).size.height,
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Note Title Text Field
//             TextField(
//               controller: _noteTitleController,
//               decoration: InputDecoration(hintText: 'Title'),
//             ),
//             SizedBox(height: 10),

//             // Note Content Text Field
//             Expanded(
//               child: TextField(
//                 controller: _noteContentController,
//                 decoration: InputDecoration(hintText: 'Content'),
//                 maxLines: null,
//                 expands: true,
//                 textAlignVertical: TextAlignVertical.top,
//               ),
//             ),
//             SizedBox(height: 20),

//             // Action buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 // Cancel button
//                 SizedBox(
//                   width: 200,
//                   height: 50,
//                   child: ButtonForNewNote(
//                     buttonName: 'Cancel',
//                     onTap: () {
//                       _noteTitleController.clear();
//                       _noteContentController.clear();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ),
//                 SizedBox(width: 20),

//                 // Create note button
//                 SizedBox(
//                   width: 200,
//                   height: 50,
//                   child: ButtonForNewNote(
//                     buttonName: 'Create',
//                     onTap: () {
//                       context.read<NotesBloc>().add(
//                         AddNewNoteButtonPressedEvent(
//                           noteTitle: _noteTitleController.text,
//                           noteContent: _noteContentController.text,
//                           notePageType: NotePageType.myNotes,
//                         ),
//                       );
//                       _noteTitleController.clear();
//                       _noteContentController.clear();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
