import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/floating_button.dart';

class FloatingActionButtonOptions extends StatefulWidget {
  const FloatingActionButtonOptions({super.key});

  @override
  State<FloatingActionButtonOptions> createState() => _FloatingActionButtonOptionsState();
}

class _FloatingActionButtonOptionsState extends State<FloatingActionButtonOptions> {

  final _noteTitleController = TextEditingController();
  final _noteContentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingButton(
              onTap: () {
                print('Share button clicked');
              },
              icon: Icons.share,
              iconSize: 30,
            ),
            SizedBox(height: 20),
            FloatingButton(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      insetPadding: EdgeInsets.zero,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            TextField(
                              controller: _noteTitleController,
                              decoration: InputDecoration(hintText: 'Title'),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: TextField(
                                controller: _noteContentController,
                                decoration: InputDecoration(
                                  hintText: 'Content',
                                ),
                                maxLines: null,
                                expands: true,
                                textAlignVertical: TextAlignVertical.top,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icons.add,
              iconSize: 50,
            ),
          ],
        ),
      ],
    );
  }
}
