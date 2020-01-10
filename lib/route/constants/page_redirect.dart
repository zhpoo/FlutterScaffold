import 'package:flutter/material.dart';
import 'package:musket/common/logger.dart';
import 'package:musket/route/routes.dart';
import 'package:musket_app/common/user.dart';
import 'package:musket_app/route/pages.dart';

class RedirectType {
  final String type;

  const RedirectType._(this.type);

  static const app = const RedirectType._('app');

  static const web = const RedirectType._('h5');
}

class RedirectParams {
  /// one of [RedirectType]
  String type;

  /// one of [RedirectPage] for [RedirectType.app] or a web url for [RedirectType.web]
  String url;

  /// title for [RedirectType.web]
  String title;

  /// mark need token
  bool isToken;

  /// optional params.
  Map<String, dynamic> params;

  RedirectParams({this.type, this.url, this.title, this.isToken, this.params});

  RedirectParams.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
    title = json['title'];
    isToken = json['is_token'];
    params = json['params'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['url'] = this.url;
    data['title'] = this.title;
    data['is_token'] = this.isToken;
    data['params'] = this.params;
    return data;
  }
}

class RedirectPage {
  /// 首页
  static const String main = 'Main';
}

class PageRedirect {
  final RedirectParams redirect;

  const PageRedirect({@required this.redirect});

  void navigate(BuildContext context) {
    if (redirect.type == RedirectType.web.type) {
      _toWebViewPage(redirect, context);
      return;
    }
    if (redirect.type == RedirectType.app.type) {
      // TODO: 跳转页面
    }
    Navigator.of(context).popUntil((route) => route.settings.name == Pages.main);
  }

  static void _toWebViewPage(RedirectParams redirect, context) {
    if (redirect.url?.isEmpty ?? true) return;
    if (!redirect.url.startsWith('http')) return;
    bool needLogin = redirect.isToken ?? false;
    StringBuffer url = StringBuffer(redirect.url);
    if (needLogin || (redirect.params?.isNotEmpty ?? false)) {
      if (!redirect.url.contains('?')) {
        url.write('?');
      }
    }

    if (redirect.params?.isNotEmpty ?? false) {
      url.write(url.toString().endsWith('?') ? '' : '&');
      url.writeAll(redirect.params.entries.map((entry) => '${entry.key}=${entry.value}'), '&');
    }

    var toWebView = (url) {
      Logger.log('toWebView url: $url');
      Routes.push(context, Pages.webView, <String, dynamic>{
        'url': url,
        'title': redirect.title,
      });
    };
    if (needLogin) {
      User().checkLogin(context, onLoginCallback: () async {
        url.write(url.toString().endsWith('?') ? '' : '&');
        url.write('token=${User().token}');
        toWebView(url.toString());
      });
    } else {
      toWebView(url.toString());
    }
  }
}
