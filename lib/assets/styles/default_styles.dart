import 'package:flutter/cupertino.dart';
import 'package:musket_app/assets/app_theme.dart';
import 'package:musket_app/assets/resources.dart';
import 'package:musket_app/assets/styles/app_theme_style.dart';
import 'package:musket_app/common/config.dart';

class DefaultAppThemeStyle implements AppThemeStyle {
  const DefaultAppThemeStyle();

  @override
  AppTheme get theme => config.theme;

  final TextStyle defaultTextStyle = const TextStyle(fontSize: 16.0);

  @override
  TextStyle get primaryText => defaultTextStyle.copyWith(color: R.color.primaryText);

  @override
  TextStyle get secondaryText => primaryText.copyWith(color: R.color.secondaryText);

  @override
  TextStyle get tertiaryText => primaryText.copyWith(color: R.color.tertiaryText);

  @override
  TextStyle get linkText => primaryText.copyWith(color: R.color.linkText);

  @override
  TextStyle get boldText => primaryText.copyWith(fontWeight: FontWeight.bold);

  @override
  TextStyle get titleText => boldText.copyWith(fontSize: 18, color: R.color.titleText);

  @override
  TextStyle get buttonText => primaryText.copyWith(color: R.color.buttonText, inherit: false);

  @override
  BorderSide get borderSide => BorderSide(color: R.color.border, width: R.dimen.borderWidth);

  @override
  Color selectColor(Color normal, Color selected, bool isSelected) {
    return isSelected ? selected : normal;
  }
}
