class FarmerAddressModel {
  int? status;
  bool? success;
  List<Data>? data;
  String? message;

  FarmerAddressModel({this.status, this.success, this.data, this.message});

  FarmerAddressModel.fromJson(Map<String, dynamic> json) {
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
  int? active;
  String? createdBy;
  String? createdOn;
  String? modifiedBy;
  String? modifiedOn;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Data(
      {this.id,
      this.farmerXid,
      this.farmAddress,
      this.farmLatitude,
      this.farmLongitude,
      this.street,
      this.city,
      this.province,
      this.country,
      this.postalCode,
      this.active,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
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
    active = json['active'];
    createdBy = json['created_by'] ?? "";
    createdOn = json['created_on'] ?? "";
    modifiedBy = json['modified_by'] ?? "";
    modifiedOn = json['modified_on'] ?? "";
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'] ?? "";
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
    data['active'] = active;
    data['created_by'] = createdBy;
    data['created_on'] = createdOn;
    data['modified_by'] = modifiedBy;
    data['modified_on'] = modifiedOn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
