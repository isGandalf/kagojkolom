import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/new_note/button_for_new_note.dart';

class AddNewNoteButtons extends StatelessWidget {
  const AddNewNoteButtons({
    super.key,
    required TextEditingController noteTitleController,
    required TextEditingController noteContentController,
  }) : _noteTitleController = noteTitleController,
       _noteContentController = noteContentController;

  final TextEditingController _noteTitleController;
  final TextEditingController _noteContentController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonForNewNote(
          buttonName: 'Cancel',
          onTap: () {
            _noteTitleController.clear();
            _noteContentController.clear();
            Navigator.of(context).pop();
          },
        ),
        SizedBox(width: 20),
        ButtonForNewNote(
          buttonName: 'Create',
          onTap: () {
            context.read<NotesBloc>().add(
              AddNewNoteButtonPressedEvent(
                noteTitle: _noteTitleController.text,
                noteContent: _noteContentController.text,
              ),
            );
            _noteTitleController.clear();
            _noteContentController.clear();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
