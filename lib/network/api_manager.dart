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
    if (onFailed != null) {
      onFailed(result);
    }
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
    if (onSuccess != null) {
      onSuccess(model, resultData);
    }
  };
}

class ApiManager {
  /// no instance.
  ApiManager._();

  static void init() {
    mergeDioBaseOptions(baseUrl: ApiUrl.baseUrl);
  }

  static Model _deliverResult<Model>(ResultData result, OnSuccess<Model> onSuccess,
      [OnFailed onFailed]) {
    if (result.isSuccessful) {
      Model model = ModelFactory.fromJson(result.body);
      _onSuccessWrapper<Model>(onSuccess)(model, result);
      return model;
    } else {
      _onFailedWrapper(onFailed)(result);
      return null;
    }
  }

  /// 为 http 统一添加公共参数
  static Http _wrapHttp(Http http) {
    if (User().isLogin) {
      http.addHeader('token', User().token);
    }
    return http;
  }

  /// GET 获取版本信息
  static getConfig({
    OnSuccess<ConfigModel> onSuccess,
    OnFailed onFailed,
  }) async {
    var http = _wrapHttp(Http.get(ApiUrl.config));
    http.addParam('type', BaseConfig.platform);
    http.addParam('version', await BaseConfig.appVersion);
    ResultData resultData = await http.call();
    _deliverResult(resultData, onSuccess, onFailed);
  }

  /// POST 登录
  static signIn({
    @required String email,
    @required String password,
    OnSuccess<SignInModel> onSuccess,
    OnFailed onFailed,
  }) async {
    var http = _wrapHttp(Http.post(ApiUrl.signIn));
    http.addParam('email', email);
    http.addParam('password', password);
    ResultData resultData = await http.call();
    _deliverResult(resultData, onSuccess, onFailed);
  }

  /// GET 用户基本信息
  static getUserProfile({OnSuccess<UserProfileModel> onSuccess, OnFailed onFailed}) async {
    var http = _wrapHttp(Http.get(ApiUrl.userProfile));
    ResultData resultData = await http.call();
    _deliverResult(resultData, onSuccess, onFailed);
  }
}
