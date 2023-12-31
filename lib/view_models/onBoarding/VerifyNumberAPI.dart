import 'package:farm_flow_sales/Utils/base_manager.dart';
import 'package:farm_flow_sales/data/network/network_api_services.dart';

class VerifyNumberAPI {
  VerifyNumberAPI(this.data);
  var data;
  Future<ResponseData<dynamic>> verifynumberApi() async {
    final response = await NetworkApiServices().postApi(
      optionalpar: true,
      data,
      "https://farmflow.betadelivery.com/api/verify-fp-otp",
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        print("token is $response");
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }
}
