
import 'package:flutter/cupertino.dart';
import 'package:musket_app/assets/app_theme.dart';
import 'package:musket_app/assets/colors/app_theme_color.dart';

/// 默认主题
class LightAppThemeColor implements AppThemeColor {
  const LightAppThemeColor();

  @override
  AppTheme get theme => AppTheme.light;

  @override
  Color get primary => const Color(0xFFFFFFFF);

  @override
  Color get primaryText => const Color(0xFF000000);

  @override
  Color get secondaryText => const Color(0XFF7F7F7F);

  @override
  Color get accent => const Color(0xFFFD6517);

  @override
  Color get accentBackground => accent;

  @override
  Color get linkText => const Color(0xFF1670F5);

  @override
  Color get border => const Color(0x1F000000);

  @override
  Color get bottomTabBarBackground => const Color(0xFFF7F7F7);

  @override
  Color get dialogContentBackground => const Color(0xB3000000);

  @override
  Color get button => accent;

  @override
  Color get secondaryButton => const Color(0xFF1670F5);

  @override
  Color get pageBackground => const Color(0xFFFFFFFF);

  @override
  Color get refreshWidgetColor => const Color(0xFFA1A1A1);

  @override
  Color get tertiaryText => const Color(0xFFBEBEBE);

  @override
  Color get buttonText => const Color(0XFFFFFFFF);

  @override
  Color get titleText => primaryText;

  @override
  Color get listBackground => const Color(0xFFF5F5F5);
}

