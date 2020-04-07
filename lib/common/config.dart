import 'package:flutter/material.dart';
import 'package:musket/common/base_config.dart';
import 'package:musket/musket.dart';
import 'package:musket_app/assets/app_theme.dart';
import 'package:musket_app/main.dart';
import 'package:musket_app/models/config_model.dart';
import 'package:musket_app/network/api_manager.dart';

final Config config = Config();

class Config with ChangeNotifier, BaseConfig {
  static Config _instance;

  Config._();

  factory Config([BuildContext context]) {
    _instance ??= Config._();
    if (context != null) listen(context);
    return _instance;
  }

  static void listen(BuildContext context) {
    Provider.of<Config>(context);
  }

  static const bool debug = BaseConfig.debug;

  /// 初始语言
  static const String initialLanguageCode = 'ja';

  static const List<String> supportLanguages = ['zh', 'en', 'ja'];

  static final Iterable<Locale> supportedLocales =
      supportLanguages.map((language) => Locale(language));

  /// 发送验证码间隔时间
  static const Duration resendVerifyCodeDuration = Duration(seconds: 60);

  AppTheme _theme;

  AppTheme get theme => _theme ?? AppTheme.light;

  void setAppTheme(AppTheme theme, [bool notify = true]) {
    if (_theme == theme) return;
    _theme = theme;
    if (!notify) return;
    initAppTheme(theme).then((_) => notifyListeners());
  }

  bool get nightMode => theme == AppTheme.dark;

  String _languageCode;

  String get languageCode => _languageCode ?? initialLanguageCode;

  set languageCode(String languageCode) {
    if (!supportLanguages.contains(languageCode)) return;
    if (languageCode == _languageCode) return;
    _languageCode = languageCode;
    notifyListeners();
  }

  /// 上次发送验证码的时间
  DateTime lastSendVerifyCodeTime;

  bool get canSendVerifyCode {
    return config.lastSendVerifyCodeTime == null ||
        DateTime.now().difference(config.lastSendVerifyCodeTime) > Config.resendVerifyCodeDuration;
  }

  int get sendVerifyCodeLeftSeconds => config.lastSendVerifyCodeTime
      .add(Config.resendVerifyCodeDuration)
      .difference(DateTime.now())
      .inSeconds;

  ConfigData _configData;

  ConfigData get configData => _configData;

  set configData(ConfigData configData) {
    if (configData == _configData) return;
    _configData = configData;
    notifyListeners();
  }

  Future<void> refreshConfig() async {
    await ApiManager.getConfig(onSuccess: (model, _) {
      if (model.code == successCode) {
        configData = model.data;
      }
    });
  }
}
