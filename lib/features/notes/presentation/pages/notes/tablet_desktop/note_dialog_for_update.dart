import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_page_type.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/three_dot_menu.dart';

class NoteDialogForUpdate extends StatefulWidget {
  final NoteEntity noteEntity;
  const NoteDialogForUpdate({super.key, required this.noteEntity});

  @override
  State<NoteDialogForUpdate> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialogForUpdate> {
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();
  NotePageType currentPage = NotePageType.myNotes;

  @override
  void initState() {
    super.initState();
    _noteTitleController.text = widget.noteEntity.noteTitle;
    _noteContentController.text = widget.noteEntity.noteContent;
  }

  @override
  void dispose() {
    _noteContentController.dispose();
    _noteTitleController.dispose();
    super.dispose();
  }

  Future<void> _updateNote() async {
    final bool titleChanged =
        _noteTitleController.text != widget.noteEntity.noteTitle;
    final bool contentChanged =
        _noteContentController.text != widget.noteEntity.noteContent;

    if (titleChanged || contentChanged) {
      context.read<NotesBloc>().add(
        UpdateNoteButtonPressedEvent(
          noteId: widget.noteEntity.noteId,
          noteTitle: _noteTitleController.text,
          noteContent: _noteContentController.text,
          createdAt: widget.noteEntity.createdAt,
          isPrivate: widget.noteEntity.isPrivate,
          isFavourite: widget.noteEntity.isFavourite,
          sharedWithUserIds: widget.noteEntity.sharedWithUserIds,
          notePageType: currentPage,
        ),
      );
    } else {
      print('No changes');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          _updateNote();
        } else {
          print('Pop failed during update');
          return;
        }
      },
      child: Dialog(
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:
                isDarkTheme
                    ? AppColorsDark.noteBackgroundColor
                    : AppColorsLight.noteBackgroundColor,
          ),
          child: Column(
            children: [
              // Note title
              TextField(
                decoration: InputDecoration(
                  hoverColor: Colors.transparent,
                  hintText: 'Title',
                ),
                controller: _noteTitleController,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),

              // Note content
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hoverColor: Colors.transparent,
                    hintText: 'Jot down your mind',
                  ),
                  controller: _noteContentController,
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Favourite icon
                  BlocBuilder<NotesBloc, NotesState>(
                    builder: (context, state) {
                      bool isFav = widget.noteEntity.isFavourite;

                      if (state is NotesLoadedState) {
                        final updatedNote = state.myNotes.firstWhere(
                          (note) => note.noteId == widget.noteEntity.noteId,
                          orElse: () => widget.noteEntity,
                        );
                        isFav = updatedNote.isFavourite;
                        currentPage = state.notePageType;
                      }

                      return IconButton(
                        onPressed: () {
                          context.read<NotesBloc>().add(
                            FavouriteButtonPressedEvent(
                              noteId: widget.noteEntity.noteId,
                              notePageType: currentPage,
                            ),
                          );
                        },
                        icon:
                            isFav
                                ? Icon(Icons.favorite)
                                : Icon(Icons.favorite_border),
                      );
                    },
                  ),
                  const SizedBox(width: 20),

                  // three dot menu
                  ThreeDotMenu(
                    noteId: widget.noteEntity.noteId,
                    notePageType: currentPage,
                  ),

                  const SizedBox(width: 20),

                  // close button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // save button
                  ElevatedButton(
                    onPressed: () {
                      _updateNote();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
