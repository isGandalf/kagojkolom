import 'package:flutter/material.dart';
import 'package:kagojkolom/core/theme/app_colors_dark.dart';
import 'package:kagojkolom/core/theme/app_colors_light.dart';
import 'package:kagojkolom/features/auth/presentation/widgets/dot_indicator.dart';

const OutlineInputBorder borderDark = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(8)),
  borderSide: BorderSide(color: AppColorsDark.focusedBorderColor, width: 1.5),
);

const OutlineInputBorder borderLight = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(8)),
  borderSide: BorderSide(color: AppColorsLight.focusedBorderColor, width: 1.5),
);

OutlineInputBorder enabledBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: BorderSide.none,
);

ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColorsDark.buttonColor,
    foregroundColor: AppColorsDark.textColor,
    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
);

const TextStyle hintTextStyle = TextStyle(
  color: AppColorsDark.hintText,
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

const TextStyle errorTextStyle = TextStyle(
  color: Color.fromARGB(255, 212, 75, 75),
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColorsDark.scaffold,
  fontFamily: 'Nunito',
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: AppColorsDark.textColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      color: AppColorsDark.textColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: AppColorsDark.textColor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    filled: true,
    fillColor: AppColorsDark.noteBackgroundColor,
    hintStyle: hintTextStyle,
    focusedBorder: borderDark,
    errorBorder: borderDark,
    focusedErrorBorder: borderDark,
    enabledBorder: enabledBorderStyle,
    errorStyle: errorTextStyle,
  ),
  iconTheme: const IconThemeData(color: AppColorsDark.noteIcon),
  drawerTheme: const DrawerThemeData(
    backgroundColor: AppColorsDark.drawerBackgroundColor,
  ),
  elevatedButtonTheme: elevatedButtonThemeData,
  tabBarTheme: TabBarTheme(
    labelColor: AppColorsDark.tabLabelTextColorSelected,
    unselectedLabelColor: AppColorsDark.tabLabelTextColorUnselected,
    labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    unselectedLabelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    dividerHeight: 0,
    tabAlignment: TabAlignment.start,
    indicator: DotIndicator(color: AppColorsDark.tabLabelTextColorSelected),
  ),
  cardTheme: CardTheme(color: AppColorsDark.noteBackgroundColor),
  bottomAppBarTheme: BottomAppBarTheme(
    color: AppColorsDark.drawerBackgroundColor,
    height: 65,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColorsDark.noteIcon,
    foregroundColor: Colors.white,
  ),
);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Nunito',
  scaffoldBackgroundColor: const Color.fromARGB(255, 223, 223, 223),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: AppColorsLight.textColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      color: AppColorsLight.textColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: AppColorsLight.textColor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color.fromARGB(255, 255, 255, 255),
    hintStyle: hintTextStyle,
    enabledBorder: enabledBorderStyle,
    focusedBorder: borderLight,
    errorBorder: borderLight,
    focusedErrorBorder: borderLight,
    errorStyle: errorTextStyle,
  ),
  iconTheme: const IconThemeData(color: AppColorsLight.noteIcon),
  drawerTheme: const DrawerThemeData(
    backgroundColor: AppColorsLight.drawerBackgroundColor,
  ),
  elevatedButtonTheme: elevatedButtonThemeData,
  tabBarTheme: TabBarTheme(
    labelColor: AppColorsLight.tabLabelTextColorSelected,
    unselectedLabelColor: AppColorsLight.tabLabelTextColorUnselected,
    labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    unselectedLabelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    dividerHeight: 0,
    tabAlignment: TabAlignment.start,
    indicator: DotIndicator(color: AppColorsLight.tabLabelTextColorSelected),
  ),
  cardTheme: CardTheme(color: AppColorsLight.noteBackgroundColor, elevation: 0),
  bottomAppBarTheme: BottomAppBarTheme(
    color: AppColorsLight.drawerBackgroundColor,
    height: 65,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColorsDark.noteIcon,
    foregroundColor: Colors.white,
  ),
);
