import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/tablet_desktop/note_page_type.dart';

class NoteDialogForNewNote extends StatefulWidget {
  const NoteDialogForNewNote({super.key});

  @override
  State<NoteDialogForNewNote> createState() => _NoteDialogForNewNoteState();
}

class _NoteDialogForNewNoteState extends State<NoteDialogForNewNote> {
  late TextEditingController _noteTitleController;
  late TextEditingController _noteContentController;
  bool isNoteSaved = false;

  @override
  void initState() {
    super.initState();
    _noteTitleController = TextEditingController();
    _noteContentController = TextEditingController();
  }

  @override
  void dispose() {
    _noteTitleController.dispose();
    _noteContentController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    if (!isNoteSaved) {
      if (_noteTitleController.text.isNotEmpty ||
          _noteContentController.text.isNotEmpty) {
        context.read<NotesBloc>().add(
          AddNewNoteButtonPressedEvent(
            noteTitle: _noteTitleController.text,
            noteContent: _noteContentController.text,
            notePageType: NotePageType.myNotes,
          ),
        );
      }
      isNoteSaved = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return PopScope<void>(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
        
          await _saveNote();
        } else {
          print('Error auto saving');
          return;
        }
      },
      child: Dialog(
        child: Container(
          width: 600,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:
                isDarkTheme
                    ? AppColorsDark.noteBackgroundColor
                    : AppColorsLight.noteBackgroundColor,
          ),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hoverColor: Colors.transparent,
                  hintText: 'Title',
                ),
                controller: _noteTitleController,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hoverColor: Colors.transparent,
                    hintText: 'Jot down your thoughts',
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      _saveNote();
                      Navigator.of(context).pop();
                    },
                    child: Text(
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
