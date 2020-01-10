import 'package:musket/common/toasts.dart';
import 'package:musket_app/assets/resources.dart';

class ErrorCode {
  Map<String, Map<String, dynamic>> codes = {
    'BAD_REQUEST': {'code': 500, 'message': 'bad request'},
    'INVALID_LANGUAGE': {'code': 501, 'message': 'invalid language'},
    'INVALID_VERSION': {'code': 502, 'message': 'invalid version'},
    'AUTH_FAILD': {'code': 600, 'message': 'auth faild'},
    'EMAIL_EXIST': {'code': 601, 'message': 'email exist'},
    'INVALID_INVITE_CODE': {'code': 602, 'message': 'invalid invite code'},
    'AUTH_CODE_FAILD': {'code': 603, 'message': 'invalid auth code'},
    'INVALID_PASSWORD': {'code': 604, 'message': 'invalid password'},
    'SIGN_EXIST': {'code': 605, 'message': 'already signed'},
    'INVALID_JOB': {'code': 606, 'message': 'invalid job'},
    'REQUEST_FREQUENTLY': {'code': 701, 'message': 'request too frequently'},
    'NEED_VIP': {'code': 703, 'message': 'need vip or buy chapter'},
    'UNENOUGH_COIN': {'code': 704, 'message': 'not enough gold coin'},
    'NEED_LOGIN': {'code': 706, 'message': 'need login'}
  };

  /// 服务端已知错误码
  static bool handleKnownCode(int code) {
    var strings = R.string;
    switch (code) {
      case 500:
      case 501:
      case 502:
        Toasts.show(msg: strings.error500);
        break;
      case 600:
        Toasts.show(msg: strings.error600);
        break;
      case 601:
        Toasts.show(msg: strings.error601);
        break;
      case 602:
        Toasts.show(msg: strings.error602);
        break;
      case 603:
        Toasts.show(msg: strings.error603);
        break;
      case 604:
        Toasts.show(msg: strings.error604);
        break;
      case 605:
        Toasts.show(msg: strings.error605);
        break;
      case 606:
        Toasts.show(msg: strings.error606);
        break;
      case 607:
        Toasts.show(msg: strings.error607);
        break;
      case 701:
        Toasts.show(msg: strings.error701);
        break;
      case 704:
        Toasts.show(msg: strings.error704);
        break;
      case 706:
        Toasts.show(msg: strings.error706);
        break;
      default:
        return false;
    }
    return true;
  }
}
