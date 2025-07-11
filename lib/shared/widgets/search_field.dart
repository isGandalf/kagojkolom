import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';
import 'package:kagojkolom/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:kagojkolom/features/auth/presentation/pages/my_profile/my_profile_parent.dart';
import 'package:kagojkolom/features/auth/presentation/pages/login/login_parent.dart';
import 'package:kagojkolom/features/auth/presentation/pages/settings/settings_parent.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/pop_up_options.dart';
import 'package:kagojkolom/features/user/presentation/bloc/user_bloc.dart';
import 'package:popover/popover.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20),
        hintText: 'Search',
        hintStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  _searchController.clear();
                },
                icon: const Icon(Icons.clear),
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is LoggedInUserState) {
                    final profilePictureUrl =
                        state.userEntity.profilePictureUrl;
                    return GestureDetector(
                      onTap: () {
                        profilePopUp(context);
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage(profilePictureUrl),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  Future<Object?> profilePopUp(BuildContext context) {
    return showPopover(
      context: context,
      width: 150,
      height: 150,
      backgroundColor: AppColorsCommon.primaryBlue,
      bodyBuilder: (context) {
        return Column(
          children: [
            PopUpOptions(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyProfileParent(),
                  ),
                );
              },
              optionName: 'My profile',
            ),
            PopUpOptions(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsParent(),
                  ),
                );
              },
              optionName: 'Settings',
            ),
            PopUpOptions(
              onTap: () {
                context.read<LoginBloc>().add(SignOutButtonPressedEvent());
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginParent()),
                  (route) => false,
                );
              },
              optionName: 'Sign out',
            ),
          ],
        );
      },
    );
  }
}
