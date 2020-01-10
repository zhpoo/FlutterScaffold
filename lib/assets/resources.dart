import 'package:flutter/cupertino.dart';
import 'package:musket_app/assets/app_theme.dart';
import 'package:musket_app/assets/colors/app_theme_color.dart';
import 'package:musket_app/assets/dimens/app_dimen.dart';
import 'package:musket_app/assets/images/app_theme_image.dart';
import 'package:musket_app/assets/strings/app_string.dart';
import 'package:musket_app/assets/styles/app_theme_style.dart';
import 'package:musket_app/common/config.dart';

abstract class Resource {
  const Resource();
}

abstract class AppThemeResource extends Resource {
  const AppThemeResource();

  AppTheme get theme;
}

abstract class LocaleResource extends Resource {
  const LocaleResource();

  String get languageCode;

  Locale get locale;
}

/// 应用内统一资源访问
class R {
  const R._();

  static AppThemeColor get color => AppThemeColor.impl(Config().theme);

  static AppThemeImage get image => AppThemeImage.impl(Config().theme);

  static AppThemeStyle get style => AppThemeStyle.impl(Config().theme);

  static AppString get string => AppString.impl(Config().languageCode);

  static AppDimen get dimen => AppDimen.impl();
}
