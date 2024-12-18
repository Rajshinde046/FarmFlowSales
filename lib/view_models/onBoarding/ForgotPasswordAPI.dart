import 'package:farm_flow_sales/Utils/base_manager.dart';
import 'package:get/get.dart';
import '../../Utils/api_urls.dart';
import 'package:farm_flow_sales/data/network/network_api_services.dart';
import 'dart:developer';

class ForgotPasswordAPI {
  ForgotPasswordAPI(
    this.data,
  );
  var data;

  Future<ResponseData<dynamic>> forgotpasswordApi() async {
    final response = await NetworkApiServices().postApi(
      data,
      "${ApiUrls.base}forgot-password",
    );
    log(response.data.toString());

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        print("token is $response");
        print("otp is $responseData");
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    } else {
      Get.back();
      log("Running");
    }
    return response;
  }

  Future<ResponseData<dynamic>> forgotpinApi() async {
    final response = await NetworkApiServices().postApi(
      data,
      "${ApiUrls.base}forgot/pin",
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        print("token is $response");
        print("otp is $responseData");
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }
}
