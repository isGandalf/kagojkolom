import 'package:flutter/material.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/update_note/update_note_view.dart';

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({
    super.key,
    required TextEditingController noteTitleController,
    required TextEditingController noteContentController,
    required this.note,
  }) : _noteTitleController = noteTitleController,
       _noteContentController = noteContentController;

  final TextEditingController _noteTitleController;
  final TextEditingController _noteContentController;
  final NoteEntity note;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: EdgeInsets.zero,
      child: UpdateNoteView(
        noteTitleController: _noteTitleController,
        noteContentController: _noteContentController,
        note: note,
      ),
    );
  }
}
