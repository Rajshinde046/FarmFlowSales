class ContactListModel {
  int? status;
  bool? success;
  Data? data;
  String? message;

  ContactListModel({this.status, this.success, this.data, this.message});

  ContactListModel.fromJson(Map<String, dynamic> json) {
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
  List<DeliveryAgent>? deliveryAgents;
  Coop? coop;

  Data({this.deliveryAgents, this.coop});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['deliveryAgents'] != null) {
      deliveryAgents = <DeliveryAgent>[];
      json['deliveryAgents'].forEach((v) {
        deliveryAgents!.add(DeliveryAgent.fromJson(v));
      });
    }
    coop = json['coop'] != null ? Coop.fromJson(json['coop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (deliveryAgents != null) {
      data['deliveryAgents'] = deliveryAgents!.map((v) => v.toJson()).toList();
    }
    if (coop != null) {
      data['coop'] = coop!.toJson();
    }
    return data;
  }
}

class Coop {
  int? id;
  String? userName;
  String? phoneNumber;
  String? emailAddress;
  String? profilePhoto;

  Coop(
      {this.id,
      this.userName,
      this.phoneNumber,
      this.emailAddress,
      this.profilePhoto});

  Coop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    phoneNumber = json['phone_number'];
    emailAddress = json['email_address'];
    profilePhoto = json['profile_photo'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_name'] = userName;
    data['phone_number'] = phoneNumber;
    data['email_address'] = emailAddress;
    data['profile_photo'] = profilePhoto;
    return data;
  }
}

class DeliveryAgent {
  int? id;
  String? userName;
  String? phoneNumber;
  String? emailAddress;
  String? profilePhoto;

  DeliveryAgent(
      {this.id,
      this.userName,
      this.phoneNumber,
      this.emailAddress,
      this.profilePhoto});

  DeliveryAgent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    phoneNumber = json['phone_number'];
    emailAddress = json['email_address'];
    profilePhoto = json['profile_photo'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_name'] = userName;
    data['phone_number'] = phoneNumber;
    data['email_address'] = emailAddress;
    data['profile_photo'] = profilePhoto;
    return data;
  }
}
