import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/pop_up_options.dart';
import 'package:popover/popover.dart';

class ThreeDotMenu extends StatelessWidget {
  final int noteId;
  const ThreeDotMenu({super.key, required this.noteId});

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
                print('share');
              },
              optionName: 'Share',
            ),
            PopUpOptions(
              onTap: () {
                context.read<NotesBloc>().add(
                  DeleteNoteButtonPressedEvent(noteId: noteId),
                );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
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
