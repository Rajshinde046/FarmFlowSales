import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:farm_flow_sales/Common/limit_range.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/api_urls.dart';
import '../../Utils/base_manager.dart';
import '../../data/network/network_api_services.dart';

class OrderApi {
  Future<ResponseData<dynamic>> getOngoingOrderData() async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.ongoingOrderApi,
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

  Future<ResponseData<dynamic>> getPendingOrdersList() async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.pendingOrderApi,
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

  Future<ResponseData<dynamic>> cancelOrderApi(String id) async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.cancelOrderApi + id,
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

  Future<ResponseData<dynamic>> getCompletedOrderData(
      String filterNumber) async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.completedOrderApi + filterNumber,
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

  Future<ResponseData<dynamic>> getOrderDetails(
    String id,
  ) async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.orderDetailsApi + id,
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

  Future<File?> downloadFile(String url, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Authorization': "Bearer ${prefs.getString('token')}",
      'Content-Type': 'application/json',
    };
    final appStorage = Directory("/storage/emulated/0/Download");
    final file = File('${appStorage.path}/$name');

    try {
      utils.showToast("Downloading...");

      final response = await Dio().get(
        url,
        options: Options(
          headers: requestHeaders,
          responseType: ResponseType.bytes,
          followRedirects: false,
          // receiveTimeout: Duration.zero,
        ),
      );
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      utils.showToast("Download Completed !");
      return file;
    } catch (e) {
      log(e.toString());
      utils.showToast("Download Error! Please try again");

      return null;
    }
  }
}
