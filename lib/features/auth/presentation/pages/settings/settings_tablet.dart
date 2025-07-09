import 'package:flutter/material.dart';
import 'package:kagojkolom/features/auth/presentation/pages/homepage/layout_type.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/settings_section.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/shared/appbar_for_about_setting.dart';

class SettingsTablet extends StatelessWidget {
  const SettingsTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarForAboutSetting(),
      body: SettingsSection(layoutType: LayoutType.tablet),
    );
  }
}