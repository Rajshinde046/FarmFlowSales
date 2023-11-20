class SalesModel {
  int? status;
  bool? success;
  Data? data;
  String? message;

  SalesModel({this.status, this.success, this.data, this.message});

  SalesModel.fromJson(Map<String, dynamic> json) {
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
  List<ProbableOrders>? probableOrders;
  SalesData? salesData;

  Data({
    this.probableOrders,
    // this.salesData
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['probableOrders'] != null) {
      probableOrders = <ProbableOrders>[];
      json['probableOrders'].forEach((v) {
        probableOrders!.add(ProbableOrders.fromJson(v));
      });
    }
    if (json['salesData'] != null) {
      salesData = SalesData.fromJson(json['salesData']);
    } else {
      salesData = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (probableOrders != null) {
      data['probableOrders'] = probableOrders!.map((v) => v.toJson()).toList();
    }
    if (salesData != null) {
      data['salesData'] = salesData!.toJson();
    }
    return data;
  }
}

class ProbableOrders {
  int? id;
  int? principalTypeXid;
  int? principalSourceXid;
  String? userName;
  String? dateOfBirth;
  String? phoneNumber;
  String? emailAddress;
  String? addressLine1;
  String? profilePhoto;
  List<FarmDetails>? farmDetails;

  ProbableOrders(
      {this.id,
      this.principalTypeXid,
      this.principalSourceXid,
      this.userName,
      this.dateOfBirth,
      this.phoneNumber,
      this.emailAddress,
      this.addressLine1,
      this.profilePhoto,
      this.farmDetails});

  ProbableOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    principalTypeXid = json['principal_type_xid'];
    principalSourceXid = json['principal_source_xid'];
    userName = json['user_name'];
    dateOfBirth = json['date_of_birth'];
    phoneNumber = json['phone_number'];
    emailAddress = json['email_address'];
    addressLine1 = json['address_line1'] ?? "";
    profilePhoto = json['profile_photo'] ?? "";
    if (json['farm_details'] != null) {
      farmDetails = <FarmDetails>[];
      json['farm_details'].forEach((v) {
        farmDetails!.add(FarmDetails.fromJson(v));
      });
    }
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
    if (farmDetails != null) {
      data['farm_details'] = farmDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesData {
  int? target;
  int? current;

  SalesData({
    this.target,
    this.current,
  });

  SalesData.fromJson(Map<String, dynamic> json) {
    target = json['target_value'];
    current = json['current_achieved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['target_value'] = target;
    data['current_achieved'] = current;

    return data;
  }
}

class FarmDetails {
  int? id;
  int? farmerXid;
  String? farmAddress;
  String? farmLatitude;
  String? farmLongitude;
  String? street;
  String? city;
  String? province;
  String? country;
  String? postalCode;

  FarmDetails(
      {this.id,
      this.farmerXid,
      this.farmAddress,
      this.farmLatitude,
      this.farmLongitude,
      this.street,
      this.city,
      this.province,
      this.country,
      this.postalCode});

  FarmDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerXid = json['farmer_xid'];
    farmAddress = json['farm_address'];
    farmLatitude = json['farm_latitude'];
    farmLongitude = json['farm_longitude'];
    street = json['street'];
    city = json['city'];
    province = json['province'];
    country = json['country'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_xid'] = farmerXid;
    data['farm_address'] = farmAddress;
    data['farm_latitude'] = farmLatitude;
    data['farm_longitude'] = farmLongitude;
    data['street'] = street;
    data['city'] = city;
    data['province'] = province;
    data['country'] = country;
    data['postal_code'] = postalCode;
    return data;
  }
}
