import 'package:farm_flow_sales/Model/cartModel/cartModel.dart';
import 'package:farm_flow_sales/Model/inventoriesModel/inventories_model.dart';
import 'package:get/get.dart';

class InventoriesController extends GetxController {
  RxBool isApiCalling = true.obs;
  RxInt cartSubTotalValue = 0.obs;
  int wareHouseId = 0;
  InventoriesDataModel inventoriesDataModel = InventoriesDataModel();
  ViewCartModel viewCartModel = ViewCartModel();
  RxBool isLoading = true.obs;
  bool fromWarehouse = false;
}
