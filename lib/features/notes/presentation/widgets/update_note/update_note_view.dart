import 'package:flutter/material.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';
import 'package:kagojkolom/features/notes/domain/entity/note_entity.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/new_note/add_note_content_text_field.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/new_note/add_note_title_text_field.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/update_note/update_note_buttons.dart';

class UpdateNoteView extends StatelessWidget {
  const UpdateNoteView({
    super.key,
    required TextEditingController noteTitleController,
    required TextEditingController noteContentController,
    required this.note,
  }) : _noteTitleController = noteTitleController,
       _noteContentController = noteContentController;

  final TextEditingController _noteTitleController;
  final TextEditingController _noteContentController;
  final NoteEntity note;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(16),
      color:
          Theme.of(context).brightness == Brightness.light
              ? AppColorsLight.scaffold
              : AppColorsDark.scaffold,
      child: Column(
        children: [
          AddNoteTitleTextFeild(noteTitleController: _noteTitleController),
          SizedBox(height: 10),
          AddNoteContentTextFeild(
            noteContentController: _noteContentController,
          ),
          SizedBox(height: 10),
          UpdateNoteButtons(
            note: note,
            noteTitle: _noteTitleController,
            noteContent: _noteContentController,
          ),
        ],
      ),
    );
  }
}
