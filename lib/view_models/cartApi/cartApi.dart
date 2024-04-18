import 'dart:developer';

import '../../Utils/api_urls.dart';
import '../../Utils/base_manager.dart';
import '../../data/network/network_api_services.dart';

class CartApi {
  Future<ResponseData<dynamic>> manageCartData(
    int id,
    int quantity,
  ) async {
    final response = await NetworkApiServices().postApi(
      {
        "item_master_lot_xid": id,
        "quantity": quantity,
      },
      ApiUrls.manageCartApi,
    );
    log(response.data.toString());
    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        return response;
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }

  Future<ResponseData<dynamic>> getViewCartData() async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.viewCartApi,
    );
    log(response.data.toString());
    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        return response;
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }

  Future<ResponseData<dynamic>> placeOrder(
    int farmerId,
    int farmId,
    String deliveryInstruction,
    int frequencyId,
    String startDate,
    int discountType,
    double discountValue,
    List<int> cartIds,
    double totalValue,
    double netValue,
    int orderType,
  ) async {
    final response = await NetworkApiServices().postApi(
      {
        "farmer_xid": farmerId,
        "farm_xid": farmId,
        "delivery_instruction": deliveryInstruction,
        "frequency_xid": frequencyId,
        "start_date": startDate,
        "discount_type": discountType,
        "discount_value": discountValue,
        "cart_ids": cartIds,
        "total_value": totalValue,
        "net_value": netValue,
        "order_type": orderType,
      },
      ApiUrls.placeOrderApi,
    );
    log(response.data.toString());
    Map<String, dynamic> responseData =
        Map<String, dynamic>.from(response.data);
    log(response.data.toString());
    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        return response;
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    } else {
      return ResponseData<dynamic>(
          responseData['message'], ResponseStatus.FAILED);
    }
  }
}
