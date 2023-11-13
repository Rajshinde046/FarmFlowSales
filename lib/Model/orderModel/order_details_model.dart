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
  List<ProductList>? deliveryAgent;
  String? oderSummary;

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
      deliveryAgent = <ProductList>[];
      json['delivery_agent'].forEach((v) {
        deliveryAgent!.add(ProductList.fromJson(v));
      });
    } else {
      deliveryAgent = null;
    }

    oderSummary = json['oder_summary'];
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
    if (deliveryAgent != null) {
      data['delivery_agent'] = deliveryAgent!.map((v) => v.toJson()).toList();
    }

    data['oder_summary'] = oderSummary;
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
