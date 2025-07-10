import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/note_page_type.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/pop_up_options.dart';
import 'package:kagojkolom/shared/widgets/custom_text_form_field.dart';
import 'package:popover/popover.dart';

class ThreeDotMenu extends StatelessWidget {
  final int noteId;
  final NotePageType notePageType;
  const ThreeDotMenu({
    super.key,
    required this.noteId,
    required this.notePageType,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder:
          (context) => GestureDetector(
            onTap: () {
              popUp(context);
            },
            child: Icon(Icons.more_vert),
          ),
    );
  }

  Future<Object?> popUp(BuildContext context) {
    return showPopover(
      backgroundColor: AppColorsCommon.primaryBlue,
      width: 150,
      height: 100,
      context: context,
      bodyBuilder: (context) {
        return Column(
          children: [
            PopUpOptions(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ShareWith(noteId: noteId),
                );
              },

              optionName: 'Share',
            ),
            PopUpOptions(
              onTap: () {
                context.read<NotesBloc>().add(
                  DeleteNoteButtonPressedEvent(
                    noteId: noteId,
                    notePageType: notePageType,
                  ),
                );
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColorsCommon.primaryBlue,
                    //behavior: SnackBarBehavior.floating,
                    content: Text(
                      'Note moved to trash',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
              optionName: 'Delete',
            ),
          ],
        );
      },
    );
  }
}

class ShareWith extends StatefulWidget {
  final int noteId;
  const ShareWith({super.key, required this.noteId});

  @override
  State<ShareWith> createState() => _ShareWithState();
}

class _ShareWithState extends State<ShareWith> {
  late TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return AlertDialog(
      backgroundColor:
          isDarkTheme ? AppColorsDark.scaffold : AppColorsLight.scaffold,
      title: Text('Share'),
      content: SizedBox(
        width: 500,
        child: TextField(
          decoration: InputDecoration(hintText: 'Email to share with'),
          controller: _emailController,
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      actions: [
        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(
              'Close',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              context.read<NotesBloc>().add(
                ShareButtonPressedEvent(
                  noteId: widget.noteId,
                  email: _emailController.text,
                ),
              );
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: AppColorsCommon.primaryBlue,
                  //behavior: SnackBarBehavior.floating,
                  content: Text(
                    'Shared',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
            child: Text(
              'Share',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
