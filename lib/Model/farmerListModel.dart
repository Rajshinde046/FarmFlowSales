class FarmerListModel {
  int? status;
  bool? success;
  List<Data>? data;
  String? message;

  FarmerListModel({this.status, this.success, this.data, this.message});

  FarmerListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  int? principalTypeXid;
  int? principalSourceXid;
  String? userName;
  String? dateOfBirth;
  String? phoneNumber;
  String? emailAddress;
  String? addressLine1;
  String? profilePhoto;

  Data(
      {this.id,
      this.principalTypeXid,
      this.principalSourceXid,
      this.userName,
      this.dateOfBirth,
      this.phoneNumber,
      this.emailAddress,
      this.addressLine1,
      this.profilePhoto});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    principalTypeXid = json['principal_type_xid'];
    principalSourceXid = json['principal_source_xid'];
    userName = json['user_name'];
    dateOfBirth = json['date_of_birth'];
    phoneNumber = json['phone_number'];
    emailAddress = json['email_address'];
    addressLine1 = json['address_line1'];
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['principal_type_xid'] = this.principalTypeXid;
    data['principal_source_xid'] = this.principalSourceXid;
    data['user_name'] = this.userName;
    data['date_of_birth'] = this.dateOfBirth;
    data['phone_number'] = this.phoneNumber;
    data['email_address'] = this.emailAddress;
    data['address_line1'] = this.addressLine1;
    data['profile_photo'] = this.profilePhoto;
    return data;
  }
}
