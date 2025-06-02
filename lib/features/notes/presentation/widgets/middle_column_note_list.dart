import 'package:flutter/material.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/three_dot_menu.dart';

class MiddleColumnNoteList extends StatelessWidget {
  const MiddleColumnNoteList({
    super.key,
    required this.noteEntityList,
    required this.selectedNote,
    required this.onSelect,
  });

  final List<NoteEntity> noteEntityList;
  final NoteEntity? selectedNote;
  final void Function(NoteEntity) onSelect;

  void sortNoteList(List<NoteEntity> noteList) {
    noteList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Widget build(BuildContext context) {
    sortNoteList(noteEntityList);
    return ListView.builder(
      itemCount: noteEntityList.length,
      itemBuilder: (context, index) {
        final note = noteEntityList[index];
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
              trailing: ThreeDotMenu(noteId: note.noteId),
            ),
            Divider(thickness: 1, height: 0),
          ],
        );
      },
    );
  }
}
