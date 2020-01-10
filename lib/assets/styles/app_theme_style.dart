import 'package:flutter/cupertino.dart';
import 'package:musket_app/assets/app_theme.dart';
import 'package:musket_app/assets/resources.dart';
import 'package:musket_app/assets/styles/default_styles.dart';

abstract class AppThemeStyle implements AppThemeResource {
  factory AppThemeStyle.impl(AppTheme theme) {
    return const DefaultAppThemeStyle();
  }

  final TextStyle primaryText;

  TextStyle get secondaryText;

  TextStyle get tertiaryText;

  TextStyle get linkText;

  TextStyle get boldText;

  TextStyle get titleText;

  TextStyle get buttonText;

  BorderSide get borderSide;

  Color selectColor(Color normal, Color selected, bool isSelected);
}
