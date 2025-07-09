import 'package:flutter/material.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/favourite_icon.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/note_dialog_for_view.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/update_note/note_dialog_for_update.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/note_page_type.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/legacy/notes_grid_view.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/three_dot_menu.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note, required this.notePageType});

  final NoteEntity note;
  final NotePageType notePageType;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(14),
      color: Colors.transparent,
      child: InkWell(
        hoverColor: AppColorsCommon.primaryBlue,
        onTap: () {
          if (notePageType == NotePageType.sharedWithMe ||
              notePageType == NotePageType.trash) {
            showDialog(
              context: context,
              builder: (context) {
                return NoteDialogForView(
                  noteEntity: note,
                  notePageType: notePageType,
                );
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return NoteDialogForUpdate(noteEntity: note);
              },
            );
          }
        },
        child: Card(
          elevation: 3,
          shadowColor: const Color.fromARGB(24, 0, 0, 0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.noteTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        note.noteContent,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      notePageType == NotePageType.trash ||
                              notePageType == NotePageType.sharedWithMe
                          ? SizedBox()
                          : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FavouriteIconButton(
                                noteId: note.noteId,
                                currentPage: notePageType,
                                key: ValueKey(note.noteId),
                              ),
                              ThreeDotMenu(
                                noteId: note.noteId,
                                notePageType: notePageType,
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
