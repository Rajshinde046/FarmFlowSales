class DashboardModel {
  int? status;
  bool? success;
  Data? data;
  String? message;

  DashboardModel({this.status, this.success, this.data, this.message});

  DashboardModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  int? inprogress;
  int? pending;
  int? complete;

  Data({this.name, this.inprogress, this.pending, this.complete});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    inprogress = json['inprogress'];
    pending = json['pending'];
    complete = json['complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['inprogress'] = inprogress;
    data['pending'] = pending;
    data['complete'] = complete;
    return data;
  }
}
