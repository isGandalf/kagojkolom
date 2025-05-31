import 'package:flutter/material.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/new_note/add_new_note_view.dart';

Future<dynamic> addNewNoteDialog(
  BuildContext context,
  TextEditingController noteTitleController,
  TextEditingController noteContentController,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        insetPadding: EdgeInsets.zero,
        child: AddNewNoteView(
          noteTitleController: noteTitleController,
          noteContentController: noteContentController,
        ),
      );
    },
  );
}
