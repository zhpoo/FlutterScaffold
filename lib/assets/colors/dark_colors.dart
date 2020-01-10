import 'package:flutter/cupertino.dart';
import 'package:musket_app/assets/app_theme.dart';
import 'package:musket_app/assets/colors/light_colors.dart';

/// 夜间模式
class DarkAppThemeColor extends LightAppThemeColor {
  const DarkAppThemeColor();

  @override
  AppTheme get theme => AppTheme.dark;

  @override
  Color get primary => const Color(0xFF000000);

  @override
  Color get pageBackground => const Color(0xFF000000);

  @override
  Color get primaryText => const Color(0xFFFFFFFF);

  @override
  Color get tertiaryText => const Color(0xFFBEBEBE);

  @override
  Color get bottomTabBarBackground => const Color(0xFF1D1D1D);

  @override
  Color get border => const Color(0xFF383838);

  @override
  Color get accentBackground => const Color(0xFF1D1D1D);

  @override
  Color get listBackground => border;
}
