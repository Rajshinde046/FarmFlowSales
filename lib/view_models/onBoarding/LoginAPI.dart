import 'package:farm_flow_sales/Utils/api_urls.dart';
import 'package:farm_flow_sales/Utils/base_manager.dart';
import 'package:farm_flow_sales/data/network/network_api_services.dart';
import 'package:farm_flow_sales/models/loginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAPI {
  LoginAPI(this.data);
  var data;
  Future<ResponseData<dynamic>> loginApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await NetworkApiServices().postApi(
      data,
      ApiUrls.loginApi,
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        loginModel loginObj = loginModel.fromJson(responseData);
        await prefs.setString('token', loginObj.data!.accessToken!);
        print("token is ${loginObj.data!.accessToken!}");
        await prefs.setString('name', loginObj.data!.name!);
      } else {
        return ResponseData<dynamic>(
            responseData['message'], ResponseStatus.FAILED);
      }
    }
    return response;
  }
}
