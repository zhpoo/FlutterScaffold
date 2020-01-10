import 'package:musket_app/assets/app_theme.dart';
import 'package:musket_app/assets/images/dark_images.dart';
import 'package:musket_app/assets/images/light_images.dart';
import 'package:musket_app/assets/resources.dart';

const _png = '.png';

const String defaultImageFolder = 'images';

/// 所有图片资源目录
/// 声明的目录需要在 [pubspec.yaml] 中声明
const Map<AppTheme, String> imageFolders = {
  AppTheme.light: defaultImageFolder,
  AppTheme.dark: 'images_dark',
};

/// Notes:
/// 定义需要根据主题变化的图片资源使用 [themeImageFolder] 来引用
/// 定义无需根据主题变化的图片资源使用 [defaultImageFolder] 来引用
abstract class AppThemeImage extends AppThemeResource {
  const AppThemeImage();

  factory AppThemeImage.impl(AppTheme theme) {
    AppThemeImage impl;
    switch (theme) {
      case AppTheme.dark:
        impl = const DarkAppThemeImage();
        break;
      case AppTheme.light:
      default:
        impl = const LightAppThemeImage();
        break;
    }
    return impl;
  }

  /// 主题所对应的图片资源目录
  String get themeImageFolder => imageFolders[theme];

  String get appLogo => '$defaultImageFolder/app_logo$_png';

  String get meSetting => '$defaultImageFolder/me_setting$_png';

  String get meNightMode => '$defaultImageFolder/me_night_mode$_png';

  String get mainRecommendSelected => '$themeImageFolder/main_recommend_selected$_png';

  String get mainRecommendUnselected => '$themeImageFolder/main_recommend_unselected$_png';

  String get mainCategorySelected => '$themeImageFolder/main_category_selected$_png';

  String get mainCategoryUnselected => '$themeImageFolder/main_category_unselected$_png';

  String get mainBookshelfSelected => '$themeImageFolder/main_bookshelf_selected$_png';

  String get mainBookshelfUnselected => '$themeImageFolder/main_bookshelf_unselected$_png';

  String get mainMeSelected => '$themeImageFolder/main_me_selected$_png';

  String get mainMeUnselected => '$themeImageFolder/main_me_unselected$_png';

  String get commonArrowRight => '$themeImageFolder/common_arrow_right$_png';

  String get commonArrowBack => '$themeImageFolder/common_arrow_back$_png';
}
