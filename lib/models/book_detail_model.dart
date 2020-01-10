import 'package:musket_app/models/simple_model.dart';

class BookDetailModel extends SimpleModel {
  int code;
  String message;

  BookDetailModel({this.code, this.message});

  BookDetailModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}
