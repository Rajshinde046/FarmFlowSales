import 'dart:developer';

import '../../Utils/api_urls.dart';
import '../../Utils/base_manager.dart';
import '../../data/network/network_api_services.dart';

class ContactUsAPI {
  Future<ResponseData<dynamic>> contactUsApi(
    String name,
    String email,
    String contactNumber,
    String subject,
    String message,
  ) async {
    final response = await NetworkApiServices().postApi(
      {
        "name": name,
        "email": email,
        "contact_number": contactNumber,
        "subject": subject,
        "message": message,
      },
      ApiUrls.contactUsApi,
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

  Future<ResponseData<dynamic>> getContactListApi() async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.contactListApi,
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
