import 'package:flutter/cupertino.dart';
import 'package:musket/common/toasts.dart';
import 'package:musket_app/assets/resources.dart';

class Errors {
  Errors._();

  static Future<bool> toastContentEmpty(BuildContext context, String content) {
    return Toasts.show(msg: '$content ${R.string.isEmpty}');
  }
}
