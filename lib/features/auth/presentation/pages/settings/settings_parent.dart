import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/pages/settings/settings_desktop.dart';
import 'package:kagojkolom/features/auth/presentation/pages/settings/settings_mobile.dart';
import 'package:kagojkolom/features/auth/presentation/pages/settings/settings_tablet.dart';
import 'package:kagojkolom/shared/responsive/responsive_layout.dart';

class SettingsParent extends StatelessWidget {
  const SettingsParent({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: SettingsMobile(),
      tabletScaffold: SettingsTablet(),
      desktopScaffold: SettingsDesktop(),
    );
  }
}
