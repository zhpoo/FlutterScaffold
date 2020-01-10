import 'package:musket_app/models/simple_model.dart';

class SignInModel extends SimpleModel {
  int code;
  SignInData data;
  String message;

  SignInModel({this.code, this.data, this.message});

  SignInModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new SignInData.fromJson(json['data']) : null;
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

class SignInData {
  UserProfile user;
  String token;

  SignInData({this.user, this.token});

  SignInData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new UserProfile.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class UserProfile {
  int level;
  int memberExpireAt;
  String name;
  int goldCoin;
  String inviteCode;
  int id;
  String avatar;
  String email;

  UserProfile(
      {this.level,
      this.memberExpireAt,
      this.name,
      this.goldCoin,
      this.inviteCode,
      this.id,
      this.avatar,
      this.email});

  UserProfile.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    memberExpireAt = json['member_expire_at'];
    name = json['name'];
    goldCoin = json['gold_coin'];
    inviteCode = json['invite_code'];
    id = json['id'];
    avatar = json['avatar'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['member_expire_at'] = this.memberExpireAt;
    data['name'] = this.name;
    data['gold_coin'] = this.goldCoin;
    data['invite_code'] = this.inviteCode;
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    return data;
  }
}
