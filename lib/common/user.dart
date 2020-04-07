import 'package:flutter/material.dart';
import 'package:musket/common/logger.dart';
import 'package:musket/musket.dart';
import 'package:musket/route/routes.dart';
import 'package:musket_app/models/sign_in_model.dart';
import 'package:musket_app/network/api_manager.dart';
import 'package:musket_app/route/constants/keys.dart';
import 'package:musket_app/route/pages.dart';

final User user = User();

class User {
  User._();

  static User _user;

  factory User() {
    _user ??= User._();
    return _user;
  }

  Future<void> onLogin(SignInData data) async {
    state.value = data?.token;
    profile.value = data?.user;
    await _syncTokenToSp();
  }

  /// 退出登录清除本地用户登录状态
  Future<void> onLogout() async {
    profile.value = null;
    state.value = null;
    await _syncTokenToSp();
  }

  /// sync [token] to shared preferences.
  Future<void> _syncTokenToSp() async {
    var sp = await SharedPreferences.getInstance();
    // value 为 null 将会自动从 sp 中 remove 掉对应的 key.
    await sp.setString(Keys.token, state.value);
  }

  Future<void> readSavedToken() async {
    if (state.value != null) {
      return;
    }
    var sp = await SharedPreferences.getInstance();
    var token = sp.getString(Keys.token) ?? '';
    state.value = token;
    Logger.log('read saved token: $token');
    await Future.wait([profile.update()]);
  }

  /// 判断登录状态，如果已登录则执行[onLoginCallback]操作，否则跳转到登录，并在成功登录后执行[onLoginCallback]
  /// [invokeAfterLogin] 表示如果未登录情况下跳转登录成功后是否执行[onLoginCallback]
  Future<void> checkLogin(
    BuildContext context, {
    VoidCallback onLoginCallback,
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

  final LoginTokenState state = LoginTokenState._(null);

  final ProfileHolder profile = ProfileHolder._(null);

  String get token => state.value ?? '';

  bool get isLogin => token.isNotEmpty;

  bool get isNotLogin => !isLogin;
}

class LoginTokenState extends ValueNotifier<String> {
  LoginTokenState._(String token) : super(token);
}

class ProfileHolder extends ValueNotifier<UserProfile> {
  ProfileHolder._(UserProfile value) : super(value);

  Future<void> update() async {
    if (user.isNotLogin) return;
    await ApiManager.getUserProfile(onSuccess: (model, _) {
      if (model.code == successCode) {
        value = model.data;
      }
    });
  }
}
