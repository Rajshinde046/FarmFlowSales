class FarmerDetailsModel {
  int? status;
  bool? success;
  Data? data;
  String? message;

  FarmerDetailsModel({this.status, this.success, this.data, this.message});

  FarmerDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  FarmerDetails? farmerDetails;
  List<FarmDetails>? farmDetails;
  List<FeedDetails>? feedDetails;

  Data({this.farmerDetails, this.farmDetails, this.feedDetails});

  Data.fromJson(Map<String, dynamic> json) {
    farmerDetails = json['farmer_details'] != null
        ? new FarmerDetails.fromJson(json['farmer_details'])
        : null;
    if (json['farm_details'] != null) {
      farmDetails = <FarmDetails>[];
      json['farm_details'].forEach((v) {
        farmDetails!.add(new FarmDetails.fromJson(v));
      });
    }
    if (json['feed_details'] != null) {
      feedDetails = <FeedDetails>[];
      json['feed_details'].forEach((v) {
        feedDetails!.add(new FeedDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.farmerDetails != null) {
      data['farmer_details'] = this.farmerDetails!.toJson();
    }
    if (this.farmDetails != null) {
      data['farm_details'] = this.farmDetails!.map((v) => v.toJson()).toList();
    }
    if (this.feedDetails != null) {
      data['feed_details'] = this.feedDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FarmerDetails {
  int? id;
  int? principalTypeXid;
  int? principalSourceXid;
  String? userName;
  String? dateOfBirth;
  String? phoneNumber;
  String? emailAddress;
  String? addressLine1;
  String? profilePhoto;

  FarmerDetails(
      {this.id,
      this.principalTypeXid,
      this.principalSourceXid,
      this.userName,
      this.dateOfBirth,
      this.phoneNumber,
      this.emailAddress,
      this.addressLine1,
      this.profilePhoto});

  FarmerDetails.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_xid'] = this.farmerXid;
    data['farm_address'] = this.farmAddress;
    data['farm_latitude'] = this.farmLatitude;
    data['farm_longitude'] = this.farmLongitude;
    data['street'] = this.street;
    data['city'] = this.city;
    data['province'] = this.province;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    return data;
  }
}

class FeedDetails {
  int? id;
  int? farmerXid;
  int? livestockTypeXid;
  int? currentFeedAvailable;
  int? feedTypeXid;
  int? feedFrequencyXid;
  int? qtyPerSeed;
  int? minBinCapacity;
  int? maxBinCapacity;
  String? reorderingDate;
  bool? feedLow;
  int? feedLowPer;
  String? livestockName;
  String? livestockUri;
  String? container;

  FeedDetails(
      {this.id,
      this.farmerXid,
      this.livestockTypeXid,
      this.currentFeedAvailable,
      this.feedTypeXid,
      this.feedFrequencyXid,
      this.qtyPerSeed,
      this.minBinCapacity,
      this.maxBinCapacity,
      this.reorderingDate,
      this.feedLow,
      this.feedLowPer,
      this.livestockName,
      this.livestockUri,
      this.container});

  FeedDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerXid = json['farmer_xid'];
    livestockTypeXid = json['livestock_type_xid'];
    currentFeedAvailable = json['current_feed_available'];
    feedTypeXid = json['feed_type_xid'];
    feedFrequencyXid = json['feed_frequency_xid'];
    qtyPerSeed = json['qty_per_seed'];
    minBinCapacity = json['min_bin_capacity'];
    maxBinCapacity = json['max_bin_capacity'];
    reorderingDate = json['reordering_date'];
    feedLow = json['feed_low'];
    feedLowPer = json['feed_low_per'];
    livestockName = json['livestock_name'];
    livestockUri = json['livestock_uri'];
    container = json['container'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_xid'] = this.farmerXid;
    data['livestock_type_xid'] = this.livestockTypeXid;
    data['current_feed_available'] = this.currentFeedAvailable;
    data['feed_type_xid'] = this.feedTypeXid;
    data['feed_frequency_xid'] = this.feedFrequencyXid;
    data['qty_per_seed'] = this.qtyPerSeed;
    data['min_bin_capacity'] = this.minBinCapacity;
    data['max_bin_capacity'] = this.maxBinCapacity;
    data['reordering_date'] = this.reorderingDate;
    data['feed_low'] = this.feedLow;
    data['feed_low_per'] = this.feedLowPer;
    data['livestock_name'] = this.livestockName;
    data['livestock_uri'] = this.livestockUri;
    data['container'] = this.container;
    return data;
  }
}
