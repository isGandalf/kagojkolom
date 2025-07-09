import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';
import 'package:kagojkolom/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:kagojkolom/features/auth/presentation/pages/login/login_parent.dart';
import 'package:kagojkolom/features/auth/presentation/pages/my_profile/my_profile_parent.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/settings_section.dart';
import 'package:kagojkolom/features/auth/presentation/pages/settings/settings_parent.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/pop_up_options.dart';
import 'package:popover/popover.dart';

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
                MaterialPageRoute(builder: (context) => const SettingsParent()),
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
