import 'package:flutter/material.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/middle_column_note_list.dart';

class AllNotesPage extends StatelessWidget {
  final List<NoteEntity> noteEntityList;
  final NoteEntity? selectedNote;
  final void Function(NoteEntity) onSelect;
  const AllNotesPage({
    super.key,
    required this.noteEntityList,
    this.selectedNote,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return MiddleColumnNoteList(
      noteEntityList: noteEntityList,
      selectedNote: selectedNote,
      onSelect: onSelect,
    );
  }
}
