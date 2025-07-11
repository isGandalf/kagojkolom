import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';
import 'package:kagojkolom/features/auth/presentation/pages/edit_profile/edit_profile_parent.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/appbar_for_about_setting.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/user/presentation/bloc/user_bloc.dart';

class MyProfileMobile extends StatelessWidget {
  const MyProfileMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBarForAboutSetting(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final width = maxWidth > 700 ? 700.0 : maxWidth;

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              heightFactor: 1.5,
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is LoggedInUserState) {
                    final firstName = state.userEntity.firstName;
                    final lastName = state.userEntity.lastName;
                    final email = state.userEntity.email;
                    final profilePictureUrl =
                        state.userEntity.profilePictureUrl;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: width),

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // User detials content
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      isDarkTheme
                                          ? AppColorsDark.noteBackgroundColor
                                          : AppColorsLight.noteBackgroundColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // profile picture
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(10),
                                          child: Image.asset(profilePictureUrl),
                                        ),
                                      ),

                                      SizedBox(width: 20),

                                      // User details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '$firstName $lastName',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                                const EditProfileParent(),
                                                      ),
                                                    );
                                                  },
                                                  icon: Icon(Icons.edit),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              email,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            BlocBuilder<NotesBloc, NotesState>(
                                              builder: (context, state) {
                                                if (state is NotesLoadedState) {
                                                  final totalNotes =
                                                      state.myNotes.length;
                                                  return Text(
                                                    'You have saved $totalNotes notes so far.',
                                                  );
                                                }
                                                return SizedBox.shrink();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
