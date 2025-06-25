import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/global/logger.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/appbar_brand_icon.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/appbar_profile_section.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/appbar_search.dart';
import 'package:kagojkolom/features/user/presentation/bloc/user_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  const CustomAppBar({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        logger.d(state.runtimeType);
        // Loading state
        if (state is UserLoadingState) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        // User logged in state
        else if (state is LoggedInUserState) {
          final firstName = state.userEntity.firstName;
          final lastName = state.userEntity.lastName;
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SizedBox(
                    height: 71,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppBarBrandIcon(),
                        AppBarSearch(searchController: searchController,),
                        AppBarProfileSection(
                          firstName: firstName,
                          lastName: lastName,
                        ),
                      ],
                    ),
                  ),
                ),
                //Divider(height: 1, thickness: 1),
              ],
            ),
          );
        }
        // fallback state
        else {
          return SizedBox.shrink();
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);
}
