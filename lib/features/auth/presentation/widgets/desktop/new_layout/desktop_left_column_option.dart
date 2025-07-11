import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/note_page_type.dart';

class DesktopLeftColumnOption extends StatelessWidget {
  final IconData icon;
  final String optionName;
  final NotePageType pageName;
  final VoidCallback onTap;

  const DesktopLeftColumnOption({
    super.key,
    required this.icon,
    required this.optionName,
    required this.pageName,
    required this.onTap,
  });

  static final BorderRadius radius = BorderRadius.only(
    topRight: Radius.circular(50),
    bottomRight: Radius.circular(50),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        NotePageType currentPage = NotePageType.myNotes;
        if (state is NotesLoadedState) {
          currentPage = state.notePageType;
        }
        final bool isSelected = pageName == currentPage;
        final lightTheme = Theme.of(context).brightness == Brightness.light;
        return Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: radius,
          color: isSelected ? AppColorsCommon.primaryBlue : Colors.transparent,
          child: InkWell(
            borderRadius: radius,
            onTap: onTap,
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(borderRadius: radius),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color:
                        isSelected
                            ? Colors.white
                            : AppColorsCommon.tabUnselected,
                  ),
                  SizedBox(width: 20),
                  Text(
                    optionName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                          isSelected
                              ? Colors.white
                              : !lightTheme
                              ? Colors.white
                              : AppColorsCommon.tabUnselected,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
