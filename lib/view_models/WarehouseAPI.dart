import 'package:farm_flow_sales/Model/WarehouseModel.dart';
import 'package:farm_flow_sales/Utils/api_urls.dart';
import 'package:farm_flow_sales/Utils/base_manager.dart';
import 'package:farm_flow_sales/data/network/network_api_services.dart';

class WarehouseAPI {
  WarehouseAPI();
  var data;
  Future<WarehouseModel> warehouseApi() async {
    final response = await NetworkApiServices().getApi1(
      ApiUrls.warehouseApi,
    );

    if (response.status == ResponseStatus.SUCCESS) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      if (responseData['success']) {
        print(responseData);
        WarehouseModel videolistObj = WarehouseModel.fromJson(responseData);
        return videolistObj;
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
