import 'package:flutter/material.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/desktop_left_column.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/tablet_middle_column.dart';

class HomepageDesktop extends StatefulWidget {
  const HomepageDesktop({super.key});

  @override
  State<HomepageDesktop> createState() => _HomepageDesktopState();
}

class _HomepageDesktopState extends State<HomepageDesktop> {
  late TextEditingController _noteTitleController;
  late TextEditingController _noteContentController;
  List<Map<String, dynamic>> sampleNotes = [
    {
      'title': 'Meeting Notes',
      'content':
          'Discuss project milestones and deadlines. Discuss project milestones and deadlines.',
      'date': DateTime.now(),
      'isFavourite': true,
      'isPrivate': false,
    },
    {
      'title': 'Grocery List',
      'content': 'Milk, eggs, bread, coffee, and fruits.',
      'date': DateTime.now(),
      'isFavourite': false,
      'isPrivate': true,
    },
    {
      'title': 'Flutter Tips',
      'content': 'Use const constructors and avoid rebuilds.',
      'date': DateTime.now(),
      'isFavourite': true,
      'isPrivate': false,
    },
    {
      'title': 'Travel Plan',
      'content': 'Book flights and hotels for June vacation.',
      'date': DateTime.now(),
      'isFavourite': false,
      'isPrivate': false,
    },
  ];

  Map<String, dynamic>? selectedNote;

  @override
  void initState() {
    super.initState();
    _noteTitleController = TextEditingController();
    _noteContentController = TextEditingController();
  }

  @override
  void dispose() {
    _noteContentController.dispose();
    _noteTitleController.dispose();
    super.dispose();
  }

  void noteSelection(Map<String, dynamic> note) {
    setState(() {
      selectedNote = note;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          DesktopLeftColumn(),
          VerticalDivider(thickness: 1, width: 0),
          SizedBox(
            width: 400,

            child: MiddleColumn(
              sampleNotes: sampleNotes,
              selectedNote: selectedNote,
              onSelect: noteSelection,
            ),
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Container(
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? AppColorsDark.noteBackgroundColor
                      : AppColorsLight.noteBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: double.infinity, child: TextField()),
                    Expanded(child: TextField()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
