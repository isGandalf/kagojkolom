import 'package:flutter/material.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/custom_note_icon.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/update_note/update_note_dialog.dart';

class NotesViewMobile extends StatefulWidget {
  const NotesViewMobile({super.key, required this.noteList});

  final List<NoteEntity> noteList;

  @override
  State<NotesViewMobile> createState() => _NotesState();
}

class _NotesState extends State<NotesViewMobile> {
  final _noteTitleController = TextEditingController();
  final _noteContentController = TextEditingController();

  @override
  void dispose() {
    _noteTitleController.dispose();
    _noteContentController.dispose();
    super.dispose();
  }

  void sortNoteList(List<NoteEntity> noteList) {
    noteList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Widget build(BuildContext context) {
    sortNoteList(widget.noteList);
    return ListView.builder(
      itemCount: widget.noteList.length,
      itemBuilder: (context, index) {
        final note = widget.noteList[index];

        // each note is a card
        return GestureDetector(
          onTap: () {
            _noteTitleController.text = note.noteTitle;
            _noteContentController.text = note.noteContent;
            showDialog(
              context: context,
              builder: (context) {
                return UpdateDialog(
                  noteTitleController: _noteTitleController,
                  noteContentController: _noteContentController,
                  note: note,
                );
              },
            );
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // note title
                  Text(
                    note.noteTitle,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),

                  // note content
                  Text(
                    note.noteContent,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),

                  // a row which will contain the time note was created at and action icons
                  Row(
                    children: [
                      // time
                      Text(note.createdAt.toString()),
                      Spacer(),
                      Row(
                        children: [
                          // share icon
                          CustomNoteIcon(
                            onPressed: () {},
                            icon: Icon(Icons.share),
                          ),

                          // favourite icon
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
