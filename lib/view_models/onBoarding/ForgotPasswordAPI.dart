import 'package:farm_flow_sales/Utils/base_manager.dart';
import 'package:farm_flow_sales/data/network/network_api_services.dart';

class ForgotPasswordAPI {
  ForgotPasswordAPI(
    this.data,
  );
  var data;

  Future<ResponseData<dynamic>> forgotpasswordApi() async {
    final response = await NetworkApiServices().postApi(
      data,
      "https://farmflow.betadelivery.com/api/forgot-password",
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

  Future<ResponseData<dynamic>> forgotpinApi() async {
    final response = await NetworkApiServices().postApi(
      optionalpar: true,
      data,
      "https://farmflow.betadelivery.com/api/forgot-password",
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
