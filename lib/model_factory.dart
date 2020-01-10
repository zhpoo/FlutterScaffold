import 'package:musket_app/models/config_model.dart';
import 'package:musket_app/models/sign_in_model.dart';
import 'package:musket_app/models/simple_model.dart';
import 'package:musket_app/models/user_profile_model.dart';

import 'models/book_detail_model.dart';

class ModelFactory {
  static T fromJson<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "ConfigModel") {
      return ConfigModel.fromJson(json) as T;
    } else if (T.toString() == "SimpleModel") {
      return SimpleModel.fromJson(json) as T;
    } else if (T.toString() == "BookDetailModel") {
      return BookDetailModel.fromJson(json) as T;
    } else if (T.toString() == "SignInModel") {
      return SignInModel.fromJson(json) as T;
    } else if (T.toString() == "UserProfileModel") {
      return UserProfileModel.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
