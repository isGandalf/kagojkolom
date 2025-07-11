import 'package:flutter/material.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/note_page_type.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/three_dot_menu.dart';
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
          child: SizedBox(
            height: 140,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(width: 0.3, color: Colors.grey.shade600),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // First column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // note title
                          Text(
                            note.noteTitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 6),
                          // note content
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                note.noteContent,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),

                    // Second column
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 3 dot popup menu
                        ThreeDotMenu(
                          noteId: note.noteId,
                          notePageType: NotePageType.myNotes,
                        ),
                        // favourite icon
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite_border),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
