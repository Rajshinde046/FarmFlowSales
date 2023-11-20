import 'dart:developer';

import 'package:farm_flow_sales/Utils/base_manager.dart';
import 'package:farm_flow_sales/data/network/network_api_services.dart';
import 'package:farm_flow_sales/models/farmerDetailsModel.dart';

class FarmerDetailsAPI {
  FarmerDetailsAPI(this.data);
  var data;
  Future<FarmerDetailsModel> farmerDetailsApi() async {
    final response = await NetworkApiServices().getApi1(
      "https://farmflow.betadelivery.com/api/farmer/$data",
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        log(responseData.toString());
        FarmerDetailsModel videolistObj =
            FarmerDetailsModel.fromJson(responseData);
        return videolistObj;
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
