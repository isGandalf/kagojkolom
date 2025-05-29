import 'package:flutter/material.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/notes_parent.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/custom_note_icon.dart';

class Notes extends StatelessWidget {
  const Notes({super.key, required this.noteList});

  final List<NoteEntity> noteList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noteList.length,
      itemBuilder: (context, index) {
        final note = noteList[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => NotesParent()));
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.noteTitle,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    note.noteContent,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(note.createdAt.toString()),
                      Spacer(),
                      Row(
                        children: [
                          CustomNoteIcon(
                            onPressed: () {},
                            icon: Icon(Icons.share),
                          ),
                          CustomNoteIcon(
                            onPressed: () {},
                            icon: Icon(Icons.favorite),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
