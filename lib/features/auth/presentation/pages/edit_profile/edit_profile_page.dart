// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:kagojkolom/core/theme/app_colors_common.dart';
// import 'package:kagojkolom/core/theme/app_colors_dark.dart';
// import 'package:kagojkolom/core/theme/app_colors_light.dart';
// import 'package:kagojkolom/features/auth/presentation/pages/edit_profile/edit_profile_view.dart';
// import 'package:kagojkolom/features/auth/presentation/pages/my_profile/my_profile_parent.dart';
// import 'package:kagojkolom/features/auth/presentation/widgets/shared/appbar_for_about_setting.dart';
// import 'package:kagojkolom/features/notes/presentation/widgets/delete_all_notes.dart';
// import 'package:kagojkolom/features/auth/presentation/widgets/shared/edit_profile_buttons.dart';
// import 'package:kagojkolom/features/auth/presentation/widgets/shared/edit_profile_picture.dart';
// import 'package:kagojkolom/features/auth/presentation/widgets/shared/edit_user_name.dart';
// import 'package:kagojkolom/features/user/presentation/bloc/user_bloc.dart';

// class EditProfilePage extends StatelessWidget {
//   const EditProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarForAboutSetting(),
//       body: Center(
//         heightFactor: 1.2,
//         child: SingleChildScrollView(
//           child: Container(
//             constraints: BoxConstraints(maxWidth: 700, maxHeight: 550),

//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Back button
//                 BackButton(onPressed: () => Navigator.pop(context)),
//                 SizedBox(width: 15),

//                 // edit profile
//                 EditProfileView(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


