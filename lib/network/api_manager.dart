import 'package:flutter/material.dart';
import 'package:musket/common/base_config.dart';
import 'package:musket/common/logger.dart';
import 'package:musket/common/toasts.dart';
import 'package:musket/network/dio/code.dart';
import 'package:musket/network/dio/http.dart';
import 'package:musket/network/dio/result_data.dart';
import 'package:musket_app/common/user.dart';
import 'package:musket_app/model_factory.dart';
import 'package:musket_app/models/config_model.dart';
import 'package:musket_app/models/sign_in_model.dart';
import 'package:musket_app/models/simple_model.dart';
import 'package:musket_app/models/user_profile_model.dart';
import 'package:musket_app/network/api_url.dart';
import 'package:musket_app/network/error_code.dart';

const successCode = 0;

typedef OnSuccess<Model> = void Function(Model model, ResultData resultData);

typedef OnFailed = void Function(ResultData resultData);

/// 统一处理请求失败结果，toast 弹出错误提示
OnFailed _onFailedWrapper(OnFailed onFailed) {
  return (ResultData result) {
    if (result.statusCode == Code.failed) {
      Logger.log('request failed with code ${Code.failed}');
    }
    if (result?.statusCode != Code.failed && result?.body is String && result.body.isNotEmpty) {
      Toasts.show(msg: result.body);
    }
    onFailed?.call(result);
  };
}

/// 统一处理message，只要 code 不等于 Code.success(200) 就弹 message
OnSuccess<Model> _onSuccessWrapper<Model>(OnSuccess<Model> onSuccess) {
  return (Model model, ResultData resultData) {
    if (model is SimpleModel && model.code != successCode && (model.message?.isNotEmpty ?? false)) {
      if (!ErrorCode.handleKnownCode(model.code)) {
        Toasts.show(msg: model.message);
      }
    }
    onSuccess?.call(model, resultData);
  };
}

extension _HttpExtension on Http {
  Future<void> addCommonParam([bool needToken = true]) async {
    options.baseUrl = ApiUrl.baseUrl;
    if (needToken && user.isLogin) {
      addHeader('token', user.token);
    }
  }

  /// 添加公共参数后执行该[Http]请求
  Future<void> execute<T>([OnSuccess<T> onSuccess, OnFailed onFailed, bool needToken = true]) async {
    await addCommonParam(needToken);
    var result = await call();
    if (result.isSuccessful) {
      T model = ModelFactory.fromJson<T>(result.body);
      _onSuccessWrapper<T>(onSuccess)(model, result);
    } else {
      _onFailedWrapper(onFailed)(result);
    }
  }
}

class ApiManager {
  /// no instance.
  ApiManager._();

  static void init() {
    mergeDioBaseOptions(baseUrl: ApiUrl.baseUrl);
  }

  /// GET 获取版本信息
  static Future<void> getConfig({
    OnSuccess<ConfigModel> onSuccess,
    OnFailed onFailed,
  }) async {
    return Http.get(ApiUrl.config)
        .addParam('type', BaseConfig.platform)
        .addParam('version', await BaseConfig.appVersion)
        .execute(onSuccess, onFailed);
  }

  /// POST 登录
  static Future<void> signIn({
    @required String email,
    @required String password,
    OnSuccess<SignInModel> onSuccess,
    OnFailed onFailed,
  }) {
    return Http.post(ApiUrl.signIn)
        .addParam('email', email)
        .addParam('password', password)
        .execute(onSuccess, onFailed);
  }

  /// GET 用户基本信息
  static Future<void> getUserProfile({OnSuccess<UserProfileModel> onSuccess, OnFailed onFailed}) async {
    return Http.get(ApiUrl.userProfile).execute(onSuccess, onFailed);
  }
}
