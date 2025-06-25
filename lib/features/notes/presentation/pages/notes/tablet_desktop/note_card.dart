import 'package:flutter/material.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/favourite_icon.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_dialog_for_update.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_page_type.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/notes_grid_view.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/three_dot_menu.dart';

class NoteCard extends StatefulWidget {
  const NoteCard({super.key, required this.note, required this.notePageType});

  final NoteEntity note;
  final NotePageType notePageType;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          hoverColor: AppColorsCommon.primaryBlue,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return NoteDialogForUpdate(noteEntity: widget.note);
              },
            );
          },
          child: Card(
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
                          widget.note.noteTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.note.noteContent,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        widget.notePageType == NotePageType.trash
                            ? SizedBox()
                            : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FavouriteIconButton(
                                  noteId: widget.note.noteId,
                                  currentPage: widget.notePageType,
                                  key: ValueKey(widget.note.noteId),
                                ),
                                ThreeDotMenu(
                                  noteId: widget.note.noteId,
                                  notePageType: widget.notePageType,
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
      ),
    );
  }
}
