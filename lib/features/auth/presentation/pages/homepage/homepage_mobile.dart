import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/mobile/bottom_nav_bar.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/floating_button.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/notes/presentation/pages/notes/notes_mobile.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/new_note/add_new_note_buttons.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/new_note/add_new_note_dialog.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/new_note/add_new_note_view.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/new_note/add_note_content_text_field.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/new_note/add_note_title_text_field.dart';
import 'package:kagojkolom/shared/widgets/search_field.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/mobile/user_header.dart';

class HomepageMobile extends StatefulWidget {
  const HomepageMobile({super.key});

  @override
  State<HomepageMobile> createState() => _HomepageMobileState();
}

class _HomepageMobileState extends State<HomepageMobile> {
  final _searchController = TextEditingController();
  final _noteTitleController = TextEditingController();
  final _noteContentController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _noteTitleController.dispose();
    _noteContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const UserHeader(),
                const SizedBox(height: 20),
                SearchField(searchController: _searchController),
                const SizedBox(height: 10),
                const NotesMobile(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingButton(
          onTap: () {
            addNewNoteDialog(
              context,
              _noteTitleController,
              _noteContentController,
            );
          },
          icon: Icons.add,
          iconSize: 20,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}
