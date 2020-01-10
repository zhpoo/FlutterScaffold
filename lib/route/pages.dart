import 'package:flutter/cupertino.dart';
import 'package:musket/route/routes.dart';
import 'package:musket/route/web/web_view_page.dart';
import 'package:musket_app/main.dart';
import 'package:musket_app/route/me/me_login_page.dart';

class Pages {
  Pages._();

  static void init() => Routes.pageGenerator = _generatePage;

  static const main = '/';
  static const webView = '/webView';
  static const meLogin = '/me/login';

  static Widget _generatePage(BuildContext context, RouteSettings settings) {
    switch (settings.name) {
      case main:
        return MainPage();
      case webView:
        return WebViewPage();
      case meLogin:
        return MeLoginPage();
      default:
        break;
    }
    throw 'unknown route: ${settings.name}, please create the page in Pages._generatePage().';
  }
}
