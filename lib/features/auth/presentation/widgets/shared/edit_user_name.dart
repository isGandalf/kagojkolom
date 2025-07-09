import 'package:flutter/material.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';

class EditUserName extends StatelessWidget {
  const EditUserName({
    super.key,
    required TextEditingController firstName,
    required this.isDarkTheme,
    required TextEditingController lastName,
  }) : _firstName = firstName,
       _lastName = lastName;

  final TextEditingController _firstName;
  final bool isDarkTheme;
  final TextEditingController _lastName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
            controller: _firstName,
            decoration: InputDecoration(
              fillColor:
                  isDarkTheme
                      ? AppColorsDark.scaffold
                      : AppColorsLight.scaffold,
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
            controller: _lastName,
            decoration: InputDecoration(
              fillColor:
                  isDarkTheme
                      ? AppColorsDark.scaffold
                      : AppColorsLight.scaffold,
            ),
          ),
        ),
      ],
    );
  }
}
