class ConfigModel {
  int code;
  ConfigData data;
  String message;

  ConfigModel({this.code, this.data, this.message});

  ConfigModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new ConfigData.fromJson(json['data']) : null;
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

class ConfigData {
  int reviewing;
  int force;
  String type;
  String version;
  String message;

  ConfigData({this.reviewing});

  ConfigData.fromJson(Map<String, dynamic> json) {
    reviewing = json['reviewing'];
    force = json['force'];
    type = json['type'];
    version = json['version'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reviewing'] = this.reviewing;
    data['force'] = this.force;
    data['type'] = this.type;
    data['version'] = this.version;
    data['message'] = this.message;
    return data;
  }
}
