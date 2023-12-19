class FarmerListModel {
  int? status;
  bool? success;
  Data? data;
  String? message;

  FarmerListModel({this.status, this.success, this.data, this.message});

  FarmerListModel.fromJson(Map<String, dynamic> json) {
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
  List<Farmers>? farmers;

  Data({this.farmers});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['farmers'] != null) {
      farmers = <Farmers>[];
      json['farmers'].forEach((v) {
        farmers!.add(Farmers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (farmers != null) {
      data['farmers'] = farmers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Farmers {
  int? id;
  int? principalTypeXid;
  int? principalSourceXid;
  String? userName;
  String? dateOfBirth;
  String? phoneNumber;
  String? emailAddress;
  Null? addressLine1;
  String? profilePhoto;
  bool? pin;
  List<FarmDetails>? farmDetails;
  List<FeedDetails>? feedDetails;

  Farmers(
      {this.id,
      this.principalTypeXid,
      this.principalSourceXid,
      this.userName,
      this.dateOfBirth,
      this.phoneNumber,
      this.emailAddress,
      this.addressLine1,
      this.profilePhoto,
      this.pin,
      this.farmDetails,
      this.feedDetails});

  Farmers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    principalTypeXid = json['principal_type_xid'];
    principalSourceXid = json['principal_source_xid'];
    userName = json['user_name'];
    dateOfBirth = json['date_of_birth'];
    phoneNumber = json['phone_number'];
    emailAddress = json['email_address'];
    addressLine1 = json['address_line1'];
    profilePhoto = json['profile_photo'];
    pin = json['pin'];
    if (json['farm_details'] != null) {
      farmDetails = <FarmDetails>[];
      json['farm_details'].forEach((v) {
        farmDetails!.add(FarmDetails.fromJson(v));
      });
    }
    if (json['feed_details'] != null) {
      feedDetails = <FeedDetails>[];
      json['feed_details'].forEach((v) {
        feedDetails!.add(FeedDetails.fromJson(v));
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
    data['pin'] = pin;
    if (farmDetails != null) {
      data['farm_details'] = farmDetails!.map((v) => v.toJson()).toList();
    }
    if (feedDetails != null) {
      data['feed_details'] = feedDetails!.map((v) => v.toJson()).toList();
    }
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_xid'] = farmerXid;
    data['livestock_type_xid'] = livestockTypeXid;
    data['current_feed_available'] = currentFeedAvailable;
    data['feed_type_xid'] = feedTypeXid;
    data['feed_frequency_xid'] = feedFrequencyXid;
    data['qty_per_seed'] = qtyPerSeed;
    data['min_bin_capacity'] = minBinCapacity;
    data['max_bin_capacity'] = maxBinCapacity;
    data['reordering_date'] = reorderingDate;
    data['feed_low'] = feedLow;
    data['feed_low_per'] = feedLowPer;
    data['livestock_name'] = livestockName;
    data['livestock_uri'] = livestockUri;
    data['container'] = container;
    return data;
  }
}
