import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/global/logger.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/note_page_type.dart';

class UpdateNoteButtons extends StatelessWidget {
  final NoteEntity note;
  final TextEditingController noteTitle;
  final TextEditingController noteContent;

  const UpdateNoteButtons({
    super.key,
    required this.note,
    required this.noteTitle,
    required this.noteContent,
  });

  @override
  Widget build(BuildContext context) {
    NotePageType currentPage = NotePageType.myNotes;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            logger.d('On pressed --> $noteTitle -- $noteContent');
            context.read<NotesBloc>().add(
              UpdateNoteButtonPressedEvent(
                noteId: note.noteId,
                noteTitle: noteTitle.text,
                noteContent: noteContent.text,
                createdAt: note.createdAt,
                isPrivate: note.isPrivate,
                isFavourite: note.isFavourite,
                sharedWithUserIds: note.sharedWithUserIds,
                notePageType: currentPage,
              ),
            );
            Navigator.of(context).pop();
          },
          child: Text('Update'),
        ),
      ],
    );
  }
}
