import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/note_page_type.dart';

class NoteDialogForView extends StatelessWidget {
  final NoteEntity noteEntity;
  final NotePageType notePageType;
  const NoteDialogForView({
    super.key,
    required this.noteEntity,
    required this.notePageType,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      child: Container(
        width: 700,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:
              isDarkTheme
                  ? AppColorsDark.noteBackgroundColor
                  : AppColorsLight.noteBackgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(noteEntity.noteTitle, style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(noteEntity.noteContent),
                    ),
                  ),
                ],
              ),
            ),
            notePageType == NotePageType.trash
                ? SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Delete note?'),
                            content: Text(
                              'Note will be deleted forever and cannot be retrieved. Do you want to proceed?',
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'No',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<NotesBloc>().add(
                                    DeleteNoteForeverButtonPressedEvent(
                                      noteId: noteEntity.noteId,
                                      notePageType: notePageType,
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Yes',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.redAccent.shade700,
                      ),
                    ),
                    child: Text(
                      'Delete forever',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
