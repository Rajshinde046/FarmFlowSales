import 'dart:developer';

import 'package:farm_flow_sales/Model/frequencyModel/frequency_model.dart';
import 'package:farm_flow_sales/Utils/api_urls.dart';
import 'package:farm_flow_sales/Utils/base_manager.dart';
import 'package:farm_flow_sales/data/network/network_api_services.dart';

import '../../Model/farmerListModel.dart';

class FarmerListAPI {
  FarmerListAPI();
  var data;
  Future<FarmerListModel> farmerApi() async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.farmerlistApi,
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        FarmerListModel videolistObj = FarmerListModel.fromJson(responseData);
        return videolistObj;
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<FrequencyModel> getFrequencyApi() async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.frequencyApi,
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        FrequencyModel videolistObj = FrequencyModel.fromJson(responseData);
        return videolistObj;
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<ResponseData<dynamic>> getFarmerAddressApi(
    int id,
  ) async {
    final response = await NetworkApiServices().postApi(
      {
        "farmer_xid": id,
      },
      ApiUrls.farmerAddressApi,
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
