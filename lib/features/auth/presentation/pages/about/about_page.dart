import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';
import 'package:kagojkolom/features/auth/presentation/pages/about/edit_profile_page.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/appbar_brand_icon.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/appbar_for_about_setting.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/appbar_profile_section.dart';
import 'package:kagojkolom/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:kagojkolom/features/user/presentation/bloc/user_bloc.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBarForAboutSetting(),
      body: Center(
        heightFactor: 1.5,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is LoggedInUserState) {
                final firstName = state.userEntity.firstName;
                final lastName = state.userEntity.lastName;
                final email = state.userEntity.email;
                final profilePictureUrl = state.userEntity.profilePictureUrl;

                return Container(
                  constraints: BoxConstraints(maxWidth: 700, maxHeight: 190),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back arrow
                      BackButton(onPressed: () => Navigator.pop(context)),
                      SizedBox(width: 15),

                      // User detials content
                      Expanded(
                        flex: 10,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // profile picture
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      10,
                                    ),
                                    child: Image.asset(
                                      profilePictureUrl ??
                                          'lib/assets/images/2151100221.jpg',
                                    ),
                                  ),
                                ),

                                SizedBox(width: 20),

                                // User details
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 394,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '$firstName $lastName',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w600,
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
                                                          EditProfilePage(),
                                                ),
                                              );
                                            },
                                            icon: Icon(Icons.edit),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      email,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 25),
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
