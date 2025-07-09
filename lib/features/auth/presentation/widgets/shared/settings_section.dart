import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagojkolom/core/theme/app_colors_common.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';
import 'package:kagojkolom/core/theme/theme_provider.dart';
import 'package:kagojkolom/features/auth/presentation/pages/homepage/layout_type.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/appbar_for_about_setting.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/reset_password_alert_box.dart';
import 'package:kagojkolom/features/user/presentation/bloc/user_bloc.dart';
import 'package:provider/provider.dart';

class SettingsSection extends StatelessWidget {
  final LayoutType layoutType;
  const SettingsSection({super.key, required this.layoutType});

  @override
  Widget build(BuildContext context) {
    const List<Widget> icons = <Widget>[
      Icon(Icons.sunny),
      Icon(Icons.dark_mode),
    ];

    bool isDarkTheme = Provider.of<ThemeProvider>(context).isDarkTheme;
    return BlocListener<UserBloc, UserState>(
      listenWhen: (previous, current) => current is UserActionStates,
      listener: (context, state) {
        if (state is ResetPasswordEmailSentFailedEvent) {
          final message = state.message;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColorsCommon.primaryBlue,
              content: Text(
                'Failed: $message',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }
        if (state is ResetPasswordEmailSentSuccessEvent) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColorsCommon.primaryBlue,
              content: Text(
                'Email sent. Please check your inbox to reset password',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }
      },
      child: Center(
        heightFactor: 1.5,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final width = maxWidth > 700 ? 700.00 : maxWidth;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                constraints: BoxConstraints(maxWidth: width, maxHeight: 160),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back arrow
                    layoutType == LayoutType.mobile
                        ? const SizedBox.shrink()
                        : BackButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                    layoutType == LayoutType.mobile
                        ? const SizedBox.shrink()
                        : const SizedBox(width: 15),

                    // Settings
                    Flexible(
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              isDarkTheme
                                  ? AppColorsDark.noteBackgroundColor
                                  : AppColorsLight.noteBackgroundColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                    child: SizedBox(
                                      child: Text(
                                        'Change theme mode',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    child: ToggleButtons(
                                      direction: Axis.horizontal,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      selectedColor: Colors.white,
                                      fillColor: AppColorsCommon.primaryBlue,
                                      color: AppColorsCommon.primaryBlue,
                                      isSelected:
                                          isDarkTheme
                                              ? <bool>[false, true]
                                              : <bool>[true, false],
                                      onPressed: (index) {
                                        Provider.of<ThemeProvider>(
                                          context,
                                          listen: false,
                                        ).toggleTheme();
                                      },
                                      children: icons,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Text(
                                      'Change your password',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return ResetPasswordAlertBox();
                                          },
                                        );
                                      },
                                      child: Text(
                                        'Reset password',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
