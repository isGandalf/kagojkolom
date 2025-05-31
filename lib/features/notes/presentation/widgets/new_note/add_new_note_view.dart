import 'package:flutter/material.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/new_note/add_new_note_buttons.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/new_note/add_note_content_text_field.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/new_note/add_note_title_text_field.dart';

class AddNewNoteView extends StatelessWidget {
  const AddNewNoteView({
    super.key,
    required TextEditingController noteTitleController,
    required TextEditingController noteContentController,
  }) : _noteTitleController = noteTitleController,
       _noteContentController = noteContentController;

  final TextEditingController _noteTitleController;
  final TextEditingController _noteContentController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          Theme.of(context).brightness == Brightness.light
              ? AppColorsLight.scaffold
              : AppColorsDark.scaffold,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          AddNoteTitleTextFeild(noteTitleController: _noteTitleController),
          SizedBox(height: 10),
          AddNoteContentTextFeild(
            noteContentController: _noteContentController,
          ),
          SizedBox(height: 10),
          AddNewNoteButtons(
            noteTitleController: _noteTitleController,
            noteContentController: _noteContentController,
          ),
        ],
      ),
    );
  }
}
