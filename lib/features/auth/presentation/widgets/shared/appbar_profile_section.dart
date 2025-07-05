import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';
import 'package:kagojkolom/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:kagojkolom/features/auth/presentation/pages/about/about_page.dart';
import 'package:kagojkolom/features/auth/presentation/pages/login/login_parent.dart';
import 'package:kagojkolom/features/notes/presentation/widgets/pop_up_options.dart';
import 'package:popover/popover.dart';

class AppBarProfileSection extends StatelessWidget {
  const AppBarProfileSection({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
  });

  final String firstName;
  final String lastName;
  final String? profilePicture;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          profilePopUp(context);
        },
        child: SizedBox(
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  firstName,
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(width: 20),
              SizedBox(
                height: 40,
                width: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    profilePicture ?? 'lib/assets/images/2151100221.jpg',
                  ),
                ),
              ),
              SizedBox(width: 20),
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
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
              optionName: 'About',
            ),
            PopUpOptions(onTap: () {}, optionName: 'Settings'),
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
