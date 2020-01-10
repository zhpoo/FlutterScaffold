import 'package:flutter/material.dart';
import 'package:musket_app/assets/app_theme.dart';
import 'package:musket_app/assets/colors/dark_colors.dart';
import 'package:musket_app/assets/colors/light_colors.dart';
import 'package:musket_app/assets/resources.dart';

abstract class AppThemeColor extends AppThemeResource {
  factory AppThemeColor.impl(AppTheme theme) {
    AppThemeColor impl;
    switch (theme) {
      case AppTheme.dark:
        impl = const DarkAppThemeColor();
        break;
      case AppTheme.light:
      default:
        impl = const LightAppThemeColor();
        break;
    }
    return impl;
  }

  Color get primary;

  Color get accent;

  Color get accentBackground;

  Color get bottomTabBarBackground;

  Color get primaryText;

  Color get secondaryText;

  Color get tertiaryText;

  Color get titleText;

  Color get buttonText;

  Color get linkText;

  Color get border;

  Color get dialogContentBackground;

  Color get pageBackground;

  Color get refreshWidgetColor;

  Color get button;

  Color get secondaryButton;

  Color get listBackground;
}
