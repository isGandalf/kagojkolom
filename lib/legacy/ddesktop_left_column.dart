// import 'package:flutter/material.dart';
// import 'package:kagojkolom/features/auth/presentation/widgets/desktop/desktop_lower_widgets_group.dart';
// import 'package:kagojkolom/features/auth/presentation/widgets/desktop/desktop_upper_widgets_group.dart';

// class DDesktopLeftColumn extends StatelessWidget {
//   final void Function(int) onPageSelect;
//   final int selectedPage;
//   const DesktopLeftColumn({
//     super.key,
//     required this.onPageSelect,
//     required this.selectedPage,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 250,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // upper widget group contain options: all notes, favourite, shared with me and calendar
//           DesktopUpperWidgetsGroup(
//             onPageSelect: onPageSelect,
//             selectedPage: selectedPage,
//           ),

//           // lower widget group contain options: delete and signout
//           DesktopLowerWidgetsGroup(
//             onPageSelect: onPageSelect,
//             selectedPage: selectedPage,
//           ),
//         ],
//       ),
//     );
//   }
// }
