// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:kagojkolom/features/auth/presentation/widgets/shared/floating_button.dart';
// import 'package:kagojkolom/features/notes/presentation/pages/notes/legacy/tablet_desktop_add_new_note_dialog_box.dart';
// import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
// import 'package:kagojkolom/features/notes/presentation/widgets/new_note/button_for_new_note.dart';

// class FloatingActionButtonOptions extends StatefulWidget {
//   const FloatingActionButtonOptions({super.key});

//   @override
//   State<FloatingActionButtonOptions> createState() =>
//       _FloatingActionButtonOptionsState();
// }

// class _FloatingActionButtonOptionsState
//     extends State<FloatingActionButtonOptions> {
//   final _noteTitleController = TextEditingController();
//   final _noteContentController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             FloatingButton(
//               onTap: () {
//                 print('Share button clicked');
//               },
//               icon: Icons.share,
//               iconSize: 30,
//             ),
//             SizedBox(height: 20),
//             FloatingButton(
//               onTap: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return TabletDesktopAddNoteDialogBox(
//                       noteTitleController: _noteTitleController,
//                       noteContentController: _noteContentController,
//                     );
//                   },
//                 );
//               },
//               icon: Icons.add,
//               iconSize: 50,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
