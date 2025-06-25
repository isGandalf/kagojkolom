import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_dialog_for_new_note.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_page_type.dart';

class TakeANoteButton extends StatelessWidget {
  const TakeANoteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 110.0),
      child: TextButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return NoteDialogForNewNote();
            },
          );
        },
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          ),
          backgroundColor: WidgetStatePropertyAll(AppColorsCommon.primaryBlue),
        ),
        label: Text(
          'Take a note',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        icon: Icon(Icons.edit_square, size: 20, color: Colors.white),
      ),
    );
  }
}
