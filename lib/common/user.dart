import 'package:flutter/material.dart';
import 'package:musket/common/logger.dart';
import 'package:musket/musket.dart';
import 'package:musket/route/routes.dart';
import 'package:musket_app/models/sign_in_model.dart';
import 'package:musket_app/network/api_manager.dart';
import 'package:musket_app/route/constants/keys.dart';
import 'package:musket_app/route/pages.dart';

typedef LoginStateListener = void Function(bool isLogin);

typedef FutureVoidCallback = Function();

class User with ChangeNotifier {
  User._();

  static User _user;

  /// 当前登录用户信息
  factory User() {
    _user ??= User._();
    return _user;
  }

  SignInData _signInData;

  Future<void> onLogin(SignInData data) async {
    _signInData = data;
    await _syncTokenToSp();
    notifyListeners();
  }

  /// 退出登录清除本地用户登录状态
  Future<void> onLogout() async {
    _signInData = null;
    await _syncTokenToSp();
    notifyListeners();
  }

  /// sync [token] to shared preferences.
  Future<void> _syncTokenToSp() async {
    var sp = await SharedPreferences.getInstance();
    // value 为 null 将会自动从 sp 中 remove 掉对应的 key.
    await sp.setString(Keys.token, User()._signInData?.token);
  }

  Future<void> readSavedToken() async {
    if (_signInData != null) {
      return;
    }
    var sp = await SharedPreferences.getInstance();
    var token = sp.getString(Keys.token) ?? '';
    _signInData = SignInData(token: token);
    Logger.log('read saved token: ${_signInData.toJson()}');
    await refreshUserProfile();
  }

  Future<void> refreshUserProfile() async {
    if (isNotLogin) return;
    await ApiManager.getUserProfile(onSuccess: (model, _) {
      _signInData.user = model.data;
      notifyListeners();
    });
  }

  /// 判断登录状态，如果已登录则执行[onLoginCallback]操作，否则跳转到登录，并在成功登录后执行[onLoginCallback]
  /// [invokeAfterLogin] 表示如果未登录情况下跳转登录成功后是否执行[onLoginCallback]
  Future<void> checkLogin(
    BuildContext context, {
    FutureVoidCallback onLoginCallback,
    bool invokeAfterLogin = true,
  }) async {
    if (isLogin) {
      if (onLoginCallback != null) {
        return onLoginCallback();
      }
    } else if (await toLogin(context) && invokeAfterLogin && onLoginCallback != null) {
      return onLoginCallback();
    }
  }

  Future<bool> toLogin(BuildContext context) async {
    bool loginSuccess = await Routes.push(context, Pages.meLogin);
    return loginSuccess ?? false;
  }

  String get token => _signInData?.token ?? '';

  bool get isLogin => token.isNotEmpty;

  bool get isNotLogin => !isLogin;
}
