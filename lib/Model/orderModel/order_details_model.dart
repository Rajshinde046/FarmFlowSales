class OrderDetailsModel {
  int? status;
  bool? success;
  Data? data;
  String? message;

  OrderDetailsModel({this.status, this.success, this.data, this.message});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? orderHeaderId;
  String? address;
  List<ProductList>? productList;
  String? discountType;
  String? discountValue;
  String? totalValue;
  String? netValue;
  int? orderStatus;
  String? deliveryAgent;
  String? oderSummary;
  List<DeliveryStatus>? deliveryStatus;

  Data(
      {this.orderHeaderId,
      this.address,
      this.productList,
      this.discountType,
      this.discountValue,
      this.totalValue,
      this.netValue,
      this.orderStatus,
      this.deliveryAgent,
      this.deliveryStatus,
      this.oderSummary});

  Data.fromJson(Map<String, dynamic> json) {
    orderHeaderId = json['order_header_id'];
    address = json['address'];
    if (json['product_list'] != null) {
      productList = <ProductList>[];
      json['product_list'].forEach((v) {
        productList!.add(ProductList.fromJson(v));
      });
    }
    discountType = json['discount_type'];
    discountValue = json['discount_value'];
    totalValue = json['total_value'];
    netValue = json['net_value'];
    orderStatus = json['order_status'];
    if (json['delivery_agent'] != null) {
      deliveryAgent = json['delivery_agent'];
    } else {
      deliveryAgent = null;
    }
    if (json['delivery_status'] != null) {
      deliveryStatus = <DeliveryStatus>[];
      json['delivery_status'].forEach((v) {
        deliveryStatus!.add(DeliveryStatus.fromJson(v));
      });
    }

    oderSummary = json['order_summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_header_id'] = orderHeaderId;
    data['address'] = address;
    if (productList != null) {
      data['product_list'] = productList!.map((v) => v.toJson()).toList();
    }
    data['discount_type'] = discountType;
    data['discount_value'] = discountValue;
    data['total_value'] = totalValue;
    data['net_value'] = netValue;
    data['order_status'] = orderStatus;

    data['delivery_agent'] = deliveryAgent!;
    if (deliveryStatus != null) {
      data['delivery_status'] = deliveryStatus!.map((v) => v.toJson()).toList();
    }
    data['oder_summary'] = oderSummary;
    return data;
  }
}

class DeliveryStatus {
  int? deliveryStatusXid;
  String? createdAt;

  DeliveryStatus({this.deliveryStatusXid, this.createdAt});

  DeliveryStatus.fromJson(Map<String, dynamic> json) {
    deliveryStatusXid = json['delivery_status_xid'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['delivery_status_xid'] = deliveryStatusXid;
    data['created_at'] = createdAt;
    return data;
  }
}

class ProductList {
  int? quantity;
  String? itemUnitValue;
  String? itemTitle;
  String? smallImageUrl;

  ProductList(
      {this.quantity, this.itemUnitValue, this.itemTitle, this.smallImageUrl});

  ProductList.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    itemUnitValue = json['item_unit_value'];
    itemTitle = json['item_title'];
    smallImageUrl = json['small_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['item_unit_value'] = itemUnitValue;
    data['item_title'] = itemTitle;
    data['small_image_url'] = smallImageUrl;
    return data;
  }
}
