// import 'package:flutter/material.dart';
// import 'package:kagojkolom/core/theme/app_colors_common.dart';
// import 'package:kagojkolom/core/theme/app_colors_light.dart';

// class TabletDrawerIcon extends StatelessWidget {
//   final bool isSelected;
//   const TabletDrawerIcon({
//     super.key,
//     required this.onPressed,
//     required this.icon,
//     required this.isSelected,
//   });

//   final VoidCallback onPressed;
//   final IconData icon;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20),
//       child: Container(
//         decoration: BoxDecoration(
//           color: isSelected ? AppColorsCommon.primaryBlue : Colors.transparent,
//           shape: BoxShape.circle,
//         ),
//         child: IconButton(
//           onPressed: onPressed,
//           icon: Icon(
//             icon,
//             color: isSelected ? Colors.white : AppColorsCommon.iconUnfocused,
//           ),
//         ),
//       ),
//     );
//   }
// }
