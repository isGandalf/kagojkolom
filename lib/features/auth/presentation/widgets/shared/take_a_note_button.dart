import 'package:flutter/material.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';
import 'package:kagojkolom/features/auth/presentation/pages/homepage/layout_type.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/new_note/note_dialog_for_new_note.dart';

class TakeANoteButton extends StatelessWidget {
  final LayoutType? layoutType;
  const TakeANoteButton({super.key, this.layoutType});

  @override
  Widget build(BuildContext context) {
    final padding = switch (layoutType) {
      LayoutType.desktop => const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 10,
      ),
      LayoutType.tablet => const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 10,
      ),
      LayoutType.mobile => const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      null => const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    };
    return Padding(
      padding: padding,
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
