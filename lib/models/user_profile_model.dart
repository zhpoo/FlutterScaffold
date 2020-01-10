import 'package:musket_app/models/simple_model.dart';

import 'sign_in_model.dart';

class UserProfileModel extends SimpleModel {
  int code;
  UserProfile data;
  String message;

  UserProfileModel({this.code, this.data, this.message});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new UserProfile.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}
