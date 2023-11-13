import 'package:farm_flow_sales/Utils/api_urls.dart';
import 'package:farm_flow_sales/Utils/base_manager.dart';
import 'package:farm_flow_sales/data/network/network_api_services.dart';

class ConnectFarmerAPI {
  ConnectFarmerAPI(this.data);
  var data;
  Future<ResponseData<dynamic>> connectFarmerApi() async {
    final response = await NetworkApiServices().postApi(
      data,
      ApiUrls.connectCodeApi,
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        print("farmer");
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }
}
