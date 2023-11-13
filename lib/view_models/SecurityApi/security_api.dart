import 'dart:developer';

import 'package:dio/dio.dart';

import '../../Utils/api_urls.dart';
import '../../Utils/base_manager.dart';
import '../../data/network/network_api_services.dart';

class SecurityApi {
  Future<ResponseData<dynamic>> changePinApi(
    int id,
    int pin,
  ) async {
    final response = await NetworkApiServices().postApi(
      FormData.fromMap({
        "id": id,
        "pin": pin,
      }),
      ApiUrls.changePinApi,
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

  Future<ResponseData<dynamic>> checkPinApi(
    int id,
    int pin,
  ) async {
    final response = await NetworkApiServices().postApi(
      FormData.fromMap({
        "id": id,
        "pin": pin,
      }),
      ApiUrls.checkPinApi,
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
}
