import 'package:flutter/material.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';

class MiddleColumnNoteList extends StatelessWidget {
  const MiddleColumnNoteList({
    super.key,
    required this.noteEntity,
    required this.selectedNote,
    required this.onSelect,
  });

  final List<NoteEntity> noteEntity;
  final NoteEntity? selectedNote;
  final void Function(NoteEntity) onSelect;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noteEntity.length,
      itemBuilder: (context, index) {
        final note = noteEntity[index];
        return Column(
          children: [
            ListTile(
              selected: selectedNote == note,
              hoverColor: const Color.fromARGB(22, 96, 125, 139),
              splashColor: const Color.fromARGB(21, 96, 125, 139),
              isThreeLine: true,
              title: Text(note.noteTitle),
              subtitle: Text(note.noteContent),
              onTap: () => onSelect(note),
            ),
            Divider(thickness: 1, height: 0),
          ],
        );
      },
    );
  }
}
