class OngoingOrderModel {
  int? status;
  bool? success;
  List<Data>? data;
  String? message;

  OngoingOrderModel({this.status, this.success, this.data, this.message});

  OngoingOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? orderHeaderId;
  GetFarmer? getFarmer;
  String? address;

  Data({
    this.orderHeaderId,
    this.getFarmer,
    this.address,
  });

  Data.fromJson(Map<String, dynamic> json) {
    orderHeaderId = json['order_header_id'];
    getFarmer = json['get_farmer'] != null
        ? GetFarmer.fromJson(json['get_farmer'])
        : null;
    address = json['address'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_header_id'] = orderHeaderId;
    if (getFarmer != null) {
      data['get_farmer'] = getFarmer!.toJson();
    }
    data['address'] = address;
    return data;
  }
}

class GetFarmer {
  int? id;
  int? principalTypeXid;
  int? principalSourceXid;
  String? userName;
  String? dateOfBirth;
  String? phoneNumber;
  String? emailAddress;
  String? addressLine1;
  String? profilePhoto;

  GetFarmer({
    this.id,
    this.principalTypeXid,
    this.principalSourceXid,
    this.userName,
    this.dateOfBirth,
    this.phoneNumber,
    this.emailAddress,
    this.addressLine1,
    this.profilePhoto,
  });

  GetFarmer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    principalTypeXid = json['principal_type_xid'];
    principalSourceXid = json['principal_source_xid'];
    userName = json['user_name'];
    dateOfBirth = json['date_of_birth'];
    phoneNumber = json['phone_number'];
    emailAddress = json['email_address'];
    addressLine1 = json['address_line1'] ?? "";
    profilePhoto = json['profile_photo'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['principal_type_xid'] = principalTypeXid;
    data['principal_source_xid'] = principalSourceXid;
    data['user_name'] = userName;
    data['date_of_birth'] = dateOfBirth;
    data['phone_number'] = phoneNumber;
    data['email_address'] = emailAddress;
    data['address_line1'] = addressLine1;
    data['profile_photo'] = profilePhoto;

    return data;
  }
}
