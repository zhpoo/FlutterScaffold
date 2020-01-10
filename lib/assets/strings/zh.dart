import 'dart:ui';

import 'app_string.dart';

class Zh implements AppString {
  const Zh();

  @override
  final String languageCode = 'zh';
  @override
  final Locale locale = const Locale('zh');

  @override
  final String appName = 'Musket';
  @override
  final String add = "添加";
  @override
  final String close = "取消";
  @override
  final String done = "完成";
  @override
  final String isEmpty = "不能为空";
  @override
  final String noRecord = "暂无数据";
  @override
  final String copy = '复制';
  @override
  final String optional = "选填";
  @override
  final String submit = "提交";
  @override
  final String success = "成功";
  @override
  final String cancel = "取消";
  @override
  final String inputError = "输入不正确";

  @override
  final String shareLink = '分享链接';
  @override
  final String error500 = '请求失败，请稍后重试';
  @override
  final String error600 = '认证失败';
  @override
  final String error601 = '邮箱已存在';
  @override
  final String error602 = '邀请码无效';
  @override
  final String error603 = '验证码无效';
  @override
  final String error604 = '密码错误';
  @override
  final String error605 = '已签到';
  @override
  final String error606 = '无效的任务';
  @override
  final String error607 = '登录信息已过期，请重新登录';
  @override
  final String error701 = '请求太频繁，请稍后重试';
  @override
  final String error704 = '金币不足';
  @override
  final String error706 = '请先登录';

  @override
  final String mainRecommend = "推荐";
  @override
  final String mainCategory = "分类";
  @override
  final String mainBookshelf = "书架";
  @override
  final String mainMe = "我的";
  @override
  final String mainPressAgainTips = '再按一次退出程序';

  @override
  final String bookFavorite = '收藏';
  @override
  final String bookshelfHistory = '历史';
  @override
  final String meSetting = '设置';

  @override
  final String meSignUp = '注册';

  @override
  final String meLogin = '登录';

  @override
  final String meLoginForgetPassword = '忘记密码？';

  @override
  final String meLoginId = '邮箱';

  @override
  final String meLoginPassword = '密码';

  @override
  final String meNightMode = '夜间模式';
}
