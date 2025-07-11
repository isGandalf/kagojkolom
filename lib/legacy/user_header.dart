// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:kagojkolom/features/user/presentation/bloc/user_bloc.dart';

// class UserHeader extends StatelessWidget {
//   const UserHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UserBloc, UserState>(
//       builder: (context, state) {
//         if (state is LoggedInUserState) {
//           final String firstName = state.userEntity.firstName;
//           final String lastName = state.userEntity.lastName;
//           final String profilePictureUrl = state.userEntity.profilePictureUrl;
//           return SizedBox(
//             height: 50,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 CircleAvatar(backgroundImage: AssetImage(profilePictureUrl)),
//               ],
//             ),
//           );
//         } else {
//           return const SizedBox.shrink();
//         }
//       },
//     );
//   }
// }
