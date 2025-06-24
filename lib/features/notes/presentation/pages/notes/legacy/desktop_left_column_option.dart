// import 'package:flutter/material.dart';
// import 'package:kagojkolom/core/theme/app_colors_common.dart';

// class DeskTopLeftColumnOption extends StatelessWidget {
//   final String optionName;
//   final VoidCallback onTap;
//   final IconData icon;
//   final bool isSelected;

//   const DeskTopLeftColumnOption({
//     super.key,
//     required this.optionName,
//     required this.onTap,
//     required this.icon,
//     required this.isSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//       hoverColor: const Color.fromARGB(22, 96, 125, 139),
//       splashColor: const Color.fromARGB(21, 96, 125, 139),
//       leading: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//         child: Icon(
//           icon,
//           color: isSelected ? Colors.white : AppColorsCommon.primaryBlue,
//         ),
//       ),
//       title: Text(
//         optionName,
//         style: TextStyle(
//           color: isSelected ? Colors.white : AppColorsCommon.tabUnselected,
//         ),
//       ),
//       selected: isSelected,
//       onTap: onTap,
//     );
//   }
// }

