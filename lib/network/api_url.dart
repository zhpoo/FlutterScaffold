import 'package:musket/common/base_config.dart';

class ApiUrl {
  ApiUrl._();

  /// 域名
  static const host = "https://xxx.yourhost.xxx";

  /// api 版本
  static const apiVersion = '/v1';

  static const apiLanguage = '/zh';

  /// 正式环境
  static const formalBaseUrl = testBaseUrl;

  /// 测试环境 TODO: base url
//  static const testBaseUrl = 'http://127.0.0.1:3000$apiVersion$apiLanguage';
  static const testBaseUrl = 'http://47.108.150.88:3000$apiVersion$apiLanguage';

  static const baseUrl = BaseConfig.debug ? testBaseUrl : formalBaseUrl;

  /// GET 获取系统配置
  static const config = '/config/version';

  /// 登录
  static const signIn = '/auth/login';

  /// GET 用户基本信息
  static const userProfile = '/user/profile';
}
