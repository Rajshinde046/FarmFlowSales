import 'dart:developer';

import 'package:dio/dio.dart';

import '../../Utils/api_urls.dart';
import '../../Utils/base_manager.dart';
import '../../data/network/network_api_services.dart';

class ConnectFarmerApi {
  Future<ResponseData<dynamic>> connnectFarmerApi(
    String connectCode,
  ) async {
    final response = await NetworkApiServices().postApi(
      FormData.fromMap({
        "connect_code": connectCode,
      }),
      ApiUrls.connectCodeApi,
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
