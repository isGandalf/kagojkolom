import 'package:flutter/material.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/notes_desktop.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/notes_mobile.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/notes_tablet.dart';
import 'package:kagojkolom/shared/responsive/responsive_layout.dart';

class NotesParent extends StatelessWidget {
  const NotesParent({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileScaffold: NotesMobile(),
      tabletScaffold: NotesTablet(),
      desktopScaffold: NotesDesktop(),
    );
  }
}
