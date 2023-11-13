class InventoryDetailsModel {
  int? status;
  bool? success;
  Data? data;
  String? message;

  InventoryDetailsModel({this.status, this.success, this.data, this.message});

  InventoryDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? title;
  String? batch;
  String? gross;
  String? tare;
  String? net;
  String? section;
  String? daycode;
  String? wbridgeNo;
  String? manufactured;
  String? analyticalConstituents;
  String? additivesPerKg;
  String? traceElementsPerKg;
  String? composition;
  int? itemCategoryXid;
  int? warehouseXid;
  int? quantity;
  int? itemLotXid;
  int? price;
  String? smallImageUrl;
  List<Media>? media;
  List<Lots>? lots;

  Data(
      {this.id,
      this.title,
      this.batch,
      this.gross,
      this.tare,
      this.net,
      this.section,
      this.daycode,
      this.wbridgeNo,
      this.manufactured,
      this.analyticalConstituents,
      this.additivesPerKg,
      this.traceElementsPerKg,
      this.composition,
      this.itemCategoryXid,
      this.warehouseXid,
      this.quantity,
      this.itemLotXid,
      this.price,
      this.smallImageUrl,
      this.media,
      this.lots});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    batch = json['batch'];
    gross = json['gross'];
    tare = json['tare'];
    net = json['net'];
    section = json['section'];
    daycode = json['daycode'];
    wbridgeNo = json['wbridge_no'];
    manufactured = json['manufactured'];
    analyticalConstituents = json['analytical_constituents'];
    additivesPerKg = json['additives_per_kg'];
    traceElementsPerKg = json['trace_elements_per_kg'];
    composition = json['composition'];
    itemCategoryXid = json['item_category_xid'];
    warehouseXid = json['warehouse_xid'];
    quantity = json['quantity'] ?? 0;
    itemLotXid = json['item_lot_xid'] ?? 0;
    price = json['price'] ?? 0;
    smallImageUrl = json['small_image_url'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
    if (json['lots'] != null) {
      lots = <Lots>[];
      json['lots'].forEach((v) {
        lots!.add(Lots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['batch'] = batch;
    data['gross'] = gross;
    data['tare'] = tare;
    data['net'] = net;
    data['section'] = section;
    data['daycode'] = daycode;
    data['wbridge_no'] = wbridgeNo;
    data['manufactured'] = manufactured;
    data['analytical_constituents'] = analyticalConstituents;
    data['additives_per_kg'] = additivesPerKg;
    data['trace_elements_per_kg'] = traceElementsPerKg;
    data['composition'] = composition;
    data['item_category_xid'] = itemCategoryXid;
    data['warehouse_xid'] = warehouseXid;
    data['quantity'] = quantity;
    data['item_lot_xid'] = itemLotXid;
    data['price'] = price;
    data['small_image_url'] = smallImageUrl;
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    if (lots != null) {
      data['lots'] = lots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Media {
  int? id;
  String? imageUrl;

  Media({this.id, this.imageUrl});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image_url'] = imageUrl;
    return data;
  }
}

class Lots {
  int? itemMasterLotXid;
  int? itemLotXid;
  String? lotName;
  int? price;
  int? quantity;
  int? prevQuantity;

  Lots(
      {this.itemMasterLotXid,
      this.itemLotXid,
      this.lotName,
      this.price,
      this.quantity,
      this.prevQuantity});

  Lots.fromJson(Map<String, dynamic> json) {
    itemMasterLotXid = json['item_master_lot_xid'];
    itemLotXid = json['item_lot_xid'];
    lotName = json['lot_name'];
    price = json['price'];
    quantity = json['quantity'];
    prevQuantity = json['prev_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_master_lot_xid'] = itemMasterLotXid;
    data['item_lot_xid'] = itemLotXid;
    data['lot_name'] = lotName;
    data['price'] = price;
    data['quantity'] = quantity;
    data['prev_quantity'] = prevQuantity;
    return data;
  }
}
