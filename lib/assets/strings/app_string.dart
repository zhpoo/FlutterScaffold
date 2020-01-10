import 'package:musket_app/assets/resources.dart';
import 'package:musket_app/assets/strings/zh.dart';

abstract class AppString implements LocaleResource {
  factory AppString.impl(String languageCode){
    var strings;
    switch (languageCode) {
      default:
        strings = const Zh();
        break;
    }
    return strings;
  }

  String get appName;
  String get submit;
  String get noRecord;
  String get add;
  String get done;
  String get success;
  String get isEmpty;
  String get close;
  String get copy;
  String get optional;
  String get cancel;
  String get inputError;
  String get shareLink;
  String get error500;
  String get error600;
  String get error601;
  String get error602;
  String get error603;
  String get error604;
  String get error605;
  String get error606;
  String get error607;
  String get error701;
  String get error704;
  String get error706;

  String get mainRecommend;
  String get mainCategory;
  String get mainBookshelf;
  String get mainMe;

  String get mainPressAgainTips;

  String get bookshelfHistory;

  String get meSetting;
  String get meLogin;
  String get meLoginId;
  String get meLoginPassword;
  String get meLoginForgetPassword;
  String get meNightMode;
  String get meSignUp;

  String get bookFavorite;
}
