import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/appbar_brand_icon.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/appbar_profile_section.dart';
import 'package:kagojkolom/features/user/presentation/bloc/user_bloc.dart';

class AppBarForAboutSetting extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarForAboutSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width < 1200;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is LoggedInUserState) {
          final firstName = state.userEntity.firstName;
          final lastName = state.userEntity.lastName;
          final profilePicture = state.userEntity.profilePictureUrl;

          return SafeArea(
            child: SizedBox(
              height: 71,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // brand icon
                  isTablet ? BrandIconForTablet() : BrandIconForDesktop(),

                  // Profile
                  AppBarProfileSection(
                    firstName: firstName,
                    lastName: lastName, profilePicture: profilePicture,
                  ),
                ],
              ),
            ),
          );
        } else if (state is UserLoadingState) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(72);
}
