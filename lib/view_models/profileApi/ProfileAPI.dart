import 'dart:developer';

import 'package:dio/dio.dart';

import '../../Utils/api_urls.dart';
import '../../Utils/base_manager.dart';
import '../../data/network/network_api_services.dart';

class ProfileAPI {
  Future<ResponseData<dynamic>> getProfileInfo() async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.profileInfoAPI,
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

  Future<ResponseData<dynamic>> deleteProfileImageAPI() async {
    final response = await NetworkApiServices().postApi(
      {},
      ApiUrls.deleteProfileImageAPI,
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        print(response);
        print(responseData);
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }

  Future<ResponseData<dynamic>> updateProfileApi(
      {required Map<String, dynamic> map}) async {
    final response = await NetworkApiServices().postApi(
      FormData.fromMap(map),
      ApiUrls.updateProfileInfoAPI,
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }

  Future<ResponseData<dynamic>> deleteProfileApi(String reason) async {
    final response = await NetworkApiServices().deleteApi(
      ApiUrls.deleteProfileApi,
      {"reason": reason},
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

  Future<ResponseData<dynamic>> logoutApi() async {
    final response = await NetworkApiServices().postApi(
      {},
      ApiUrls.lougoutApi,
    );
    log(response.toString());
    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['message'] == "Logged out successfully.") {
        return response;
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }
}
