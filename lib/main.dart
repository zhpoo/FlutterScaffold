import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:musket/common/abstracts.dart';
import 'package:musket/common/logger.dart';
import 'package:musket/common/utils.dart';
import 'package:musket/musket.dart';
import 'package:musket/route/mixin/bottom_navigation_bar_mixin.dart';
import 'package:musket/route/routes.dart';
import 'package:musket/widget/button.dart';
import 'package:musket/widget/divider.dart';
import 'package:musket/widget/item_text.dart';
import 'package:musket/widget/no_record.dart';
import 'package:musket/widget/text_button.dart';
import 'package:musket/widget/text_input.dart';
import 'package:musket/widget/title_bar.dart';
import 'package:musket_app/assets/app_theme.dart';
import 'package:musket_app/assets/resources.dart';
import 'package:musket_app/common/config.dart';
import 'package:musket_app/common/user.dart';
import 'package:musket_app/network/api_manager.dart';
import 'package:musket_app/route/bookshelf/bookshelf_page.dart';
import 'package:musket_app/route/category/category_page.dart';
import 'package:musket_app/route/constants/keys.dart';
import 'package:musket_app/route/me/me_page.dart';
import 'package:musket_app/route/pages.dart';
import 'package:musket_app/route/recommend/recommend_page.dart';
import 'package:provider/provider.dart';

Future<void> initAppTheme([AppTheme theme]) async {
  if (theme == null) {
    var sp = await SharedPreferences.getInstance();
    bool nightMode = sp.getBool(Keys.settingNightModeSwitch) ?? false;
    theme = nightMode ? AppTheme.dark : AppTheme.light;
    config.setAppTheme(theme, false);
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: config.nightMode ? Brightness.light : Brightness.dark,
    statusBarBrightness: config.nightMode ? Brightness.dark : Brightness.light,
  ));

  TitleBar.defaultStyle = TitleBarStyle(
    titleStyle: R.style.titleText,
    backAsset: R.image.commonArrowBack,
  );
  ItemText.defaultStyle = R.style.primaryText;
  ItemText.rightArrowImage = R.image.commonArrowRight;
  Line.defaultStyle = LineStyle(color: R.color.border, height: R.dimen.borderWidth);
  TextButton.defaultStyle = R.style.linkText;
  Button.defaultButtonStyle = ButtonStyle(
    style: R.style.boldText.copyWith(color: R.color.buttonText, fontSize: 16),
    color: R.color.accent,
  );
  NoRecord.defaultStyle = R.style.secondaryText;
  NoRecord.defaultText = R.string.noRecord;
  TextInputWidget.defaultStyle = R.style.primaryText;
  TextInputWidget.defaultHintStyle = R.style.tertiaryText;
  TextInputWidget.defaultLabelStyle = R.style.primaryText;
  TextInputWidget.defaultBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: R.color.border, width: R.dimen.borderWidth),
  );
  EasyRefresh.defaultHeader = BallPulseHeader(
    color: R.color.refreshWidgetColor,
    backgroundColor: R.color.pageBackground,
  );
  EasyRefresh.defaultFooter = BallPulseFooter(
    color: R.color.refreshWidgetColor,
    backgroundColor: R.color.pageBackground,
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiManager.init();
  Pages.init();
  initAppTheme().then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<Config>.value(value: config),
        ],
        child: App(),
      ),
    );
  });
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Pages.main,
      onGenerateRoute: Routes.onGenerateRoute,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: Config.supportedLocales,
      locale: Locale(Config(context).languageCode),
      theme: ThemeData(
        primaryColor: R.color.primary,
        primaryColorBrightness: config.nightMode ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor: R.color.pageBackground,
        // textBaseline: TextBaseline.alphabetic解决 TextField hint 不居中对齐的问题
        textTheme: TextTheme(subtitle1: const TextStyle(textBaseline: TextBaseline.alphabetic)),
        cursorColor: R.color.primaryText,
        toggleableActiveColor: R.color.accent,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends BaseMainPageSate<MainPage> {
  @override
  List<Widget> get pages {
    return [
      RecommendPage(key: const ValueKey('main.recommend'), isVisible: currentIndex == 0),
      CategoryPage(key: const ValueKey('main.category')),
      BookshelfPage(key: const ValueKey('main.bookshelf')),
      MePage(key: const ValueKey('main.me'), visible: currentIndex == 3),
    ];
  }

  @override
  void initState() {
    super.initState();
    postFrameCallback(() {
      User().readSavedToken();
      checkAppVersion();
    });
  }

  @override
  List<NavigationBarItem> get navigationBarItems {
    return [
      NavigationBarItem(
        title: R.string.mainRecommend,
        icon: R.image.mainRecommendUnselected,
        activeIcon: R.image.mainRecommendSelected,
      ),
      NavigationBarItem(
        title: R.string.mainCategory,
        icon: R.image.mainCategoryUnselected,
        activeIcon: R.image.mainCategorySelected,
      ),
      NavigationBarItem(
        title: R.string.mainBookshelf,
        icon: R.image.mainBookshelfUnselected,
        activeIcon: R.image.mainBookshelfSelected,
      ),
      NavigationBarItem(
        title: R.string.mainMe,
        icon: R.image.mainMeUnselected,
        activeIcon: R.image.mainMeSelected,
      ),
    ];
  }

  @override
  NavigationBarStyle get navigationBarStyle {
    return NavigationBarStyle(
      backgroundColor: R.color.bottomTabBarBackground,
      selectedItemColor: R.color.accent,
      unselectedItemColor: R.color.secondaryText,
    );
  }

  @override
  String get pressAgainTips => R.string.mainPressAgainTips;

  void checkAppVersion() {
    // TODO: 版本更新
    Logger.log('checking version method is not implemented yet.');
  }
}
