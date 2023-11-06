class loginModel {
  int? status;
  bool? success;
  Data? data;
  String? message;

  loginModel({this.status, this.success, this.data, this.message});

  loginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? accessToken;
  int? userId;
  String? name;
  List<int>? permissions;

  Data({this.accessToken, this.userId, this.name, this.permissions});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    userId = json['user_id'];
    name = json['name'];
    permissions = json['permissions'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['user_id'] = userId;
    data['name'] = name;
    data['permissions'] = permissions;
    return data;
  }
}
