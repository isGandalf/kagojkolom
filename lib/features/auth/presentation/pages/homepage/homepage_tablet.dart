import 'package:flutter/material.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/notes_grid_view.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/custom_app_bar.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/tablet/new_layout/tablet_left_column.dart';

class HomepageTablet extends StatefulWidget {
  const HomepageTablet({super.key});

  @override
  State<HomepageTablet> createState() => _HomepageTabletState();
}

class _HomepageTabletState extends State<HomepageTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          // Left column icons
          TabletLeftColumn(),

          // Gridview
          NotesGridView(),
        ],
      ),
    );
  }
}
