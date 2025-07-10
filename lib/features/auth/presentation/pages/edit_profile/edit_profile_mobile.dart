import 'package:flutter/material.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';
import 'package:kagojkolom/features/auth/presentation/pages/edit_profile/edit_profile_view/edit_profile_view_mobile.dart';
import 'package:kagojkolom/features/auth/presentation/pages/edit_profile/edit_profile_view/edit_profile_view_parent.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/appbar_for_about_setting.dart';

class EditProfileMobile extends StatelessWidget {
  const EditProfileMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBarForAboutSetting(),
        body: Center(
          heightFactor: 1.2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(maxWidth: 700),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:
                      isDarkTheme
                          ? AppColorsDark.drawerBackgroundColor
                          : AppColorsLight.drawerBackgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: EditProfileViewParent(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
