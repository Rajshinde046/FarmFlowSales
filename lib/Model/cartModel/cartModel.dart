class ViewCartModel {
  int? status;
  bool? success;
  Data? data;
  String? message;

  ViewCartModel({this.status, this.success, this.data, this.message});

  ViewCartModel.fromJson(Map<String, dynamic> json) {
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
  int? subTotal;
  List<Cart>? cart;

  Data({this.subTotal, this.cart});

  Data.fromJson(Map<String, dynamic> json) {
    subTotal = json['subTotal'];
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(Cart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subTotal'] = subTotal;
    if (cart != null) {
      data['cart'] = cart!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cart {
  int? id;
  int? itemMasterLotXid;
  int? quantity;
  List<GetItems>? getItems;

  Cart({this.id, this.itemMasterLotXid, this.quantity, this.getItems});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemMasterLotXid = json['item_master_lot_xid'];
    quantity = json['quantity'];
    if (json['getItems'] != null) {
      getItems = <GetItems>[];
      json['getItems'].forEach((v) {
        getItems!.add(GetItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item_master_lot_xid'] = itemMasterLotXid;
    data['quantity'] = quantity;
    if (getItems != null) {
      data['getItems'] = getItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetItems {
  int? itemMasterLotXid;
  int? itemLotXid;
  String? lotName;
  int? price;
  int? quantity;
  int? prevQuantity;
  Item? item;

  GetItems(
      {this.itemMasterLotXid,
      this.itemLotXid,
      this.lotName,
      this.price,
      this.quantity,
      this.prevQuantity,
      this.item});

  GetItems.fromJson(Map<String, dynamic> json) {
    itemMasterLotXid = json['item_master_lot_xid'];
    itemLotXid = json['item_lot_xid'];
    lotName = json['lot_name'];
    price = json['price'];
    quantity = json['quantity'];
    prevQuantity = json['prev_quantity'];
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_master_lot_xid'] = itemMasterLotXid;
    data['item_lot_xid'] = itemLotXid;
    data['lot_name'] = lotName;
    data['price'] = price;
    data['quantity'] = quantity;
    data['prev_quantity'] = prevQuantity;
    if (item != null) {
      data['item'] = item!.toJson();
    }
    return data;
  }
}

class Item {
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
  String? smallImageUrl;
  String? largeImageUrl;
  int? active;
  String? createdBy;
  String? createdOn;
  String? modifiedBy;
  String? modifiedOn;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Item(
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
      this.smallImageUrl,
      this.largeImageUrl,
      this.active,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Item.fromJson(Map<String, dynamic> json) {
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
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'] ?? "";
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
    data['small_image_url'] = smallImageUrl;
    data['large_image_url'] = largeImageUrl;
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
