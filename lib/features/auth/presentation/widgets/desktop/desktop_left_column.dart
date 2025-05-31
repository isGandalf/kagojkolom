import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/desktop/desktop_lower_widgets_group.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/desktop/desktop_upper_widgets_group.dart';

class DesktopLeftColumn extends StatelessWidget {
  const DesktopLeftColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // upper widget group contain options: all notes, favourite, shared with me and calendar
          DesktopUpperWidgetsGroup(),

          // lower widget group contain options: delete and signout
          DesktopLowerWidgetsGroup(),
        ],
      ),
    );
  }
}
