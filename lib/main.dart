import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:musket/common/logger.dart';
import 'package:musket/common/toasts.dart';
import 'package:musket/common/utils.dart';
import 'package:musket/musket.dart';
import 'package:musket/route/mixin/lazy_indexed_pages.dart';
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
    Config().setAppTheme(theme, false);
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Config().nightMode ? Brightness.light : Brightness.dark,
    statusBarBrightness: Config().nightMode ? Brightness.dark : Brightness.light,
  ));

  TitleBar.defaultTitleStyle = R.style.titleText;
  TitleBar.backAsset = R.image.commonArrowBack;
  ItemText.defaultStyle = R.style.primaryText;
  ItemText.rightArrowImage = R.image.commonArrowRight;
  Line.defaultColor = R.color.border;
  Line.defaultHeight = R.dimen.borderWidth;
  TextButton.defaultStyle = R.style.linkText;
  Button.defaultStyle = R.style.boldText.copyWith(color: R.color.buttonText, fontSize: 16);
  Button.defaultColor = R.color.accent;
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
          ChangeNotifierProvider<Config>.value(value: Config()),
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
        primaryColorBrightness: Config().nightMode ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor: R.color.pageBackground,
        // textBaseline: TextBaseline.alphabetic解决 TextField hint 不居中对齐的问题
        textTheme: TextTheme(subhead: const TextStyle(textBaseline: TextBaseline.alphabetic)),
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

class _MainPageState extends State<MainPage> with LazyIndexedPagesMixin {
  DateTime _lastPressBackTime;

  @override
  List<Widget> get pages {
    return [
      RecommendPage(key: const ValueKey('main.recommend'), isVisible: currentPageIndex == 0),
      CategoryPage(key: const ValueKey('main.category')),
      BookshelfPage(key: const ValueKey('main.bookshelf')),
      MePage(key: const ValueKey('main.me'), visible: currentPageIndex == 3),
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        // 使用 IndexedStack 解决切换 Tab 后页面状态丢失的问题
        body: IndexedStack(index: currentPageIndex, children: lazyPages),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.5,
          backgroundColor: R.color.bottomTabBarBackground,
          items: buildNavBarItems(),
          currentIndex: currentPageIndex,
          onTap: changePage,
          selectedItemColor: R.color.primaryText,
          unselectedItemColor: R.color.tertiaryText,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  void changePage(int index) {
    if (currentPageIndex == index) {
      return;
    }
    setState(() {
      currentPageIndex = index;
    });
  }

  Future<bool> onWillPop() async {
    if (_lastPressBackTime == null ||
        DateTime.now().difference(_lastPressBackTime) > Duration(seconds: 2)) {
      _lastPressBackTime = DateTime.now();
      Toasts.show(msg: R.string.mainPressAgainTips);
      return false;
    }
    return true;
  }

  List<BottomNavigationBarItem> buildNavBarItems() {
    var strings = R.string;
    return [
      buildNavItem(
        strings.mainRecommend,
        R.image.mainRecommendUnselected,
        R.image.mainRecommendSelected,
      ),
      buildNavItem(
        strings.mainCategory,
        R.image.mainCategoryUnselected,
        R.image.mainCategorySelected,
      ),
      buildNavItem(
        strings.mainBookshelf,
        R.image.mainBookshelfUnselected,
        R.image.mainBookshelfSelected,
      ),
      buildNavItem(
        strings.mainMe,
        R.image.mainMeUnselected,
        R.image.mainMeSelected,
      ),
    ];
  }

  BottomNavigationBarItem buildNavItem(String title, String icon, String activeIcon) {
    return BottomNavigationBarItem(
      icon: Image.asset(icon, height: R.dimen.iconSize, width: R.dimen.iconSize),
      activeIcon: Image.asset(activeIcon, width: R.dimen.iconSize, height: R.dimen.iconSize),
      title: Text(title),
    );
  }

  void checkAppVersion() {
    // TODO: 版本更新
    Logger.log('checking version method is not implemented yet.');
  }
}
