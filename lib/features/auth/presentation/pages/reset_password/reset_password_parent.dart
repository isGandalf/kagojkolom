import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/pages/reset_password/reset_password_desktop.dart';
import 'package:kagojkolom/features/auth/presentation/pages/reset_password/reset_password_mobile.dart';
import 'package:kagojkolom/features/auth/presentation/pages/reset_password/reset_password_tablet.dart';
import 'package:kagojkolom/shared/responsive/responsive_layout.dart';

class ResetPasswordParent extends StatelessWidget {
  const ResetPasswordParent({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: ResetPasswordMobile(),
      tabletScaffold: ResetPasswordTablet(),
      desktopScaffold: ResetPasswordDesktop(),
    );
  }
}
