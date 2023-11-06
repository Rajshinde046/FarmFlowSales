import 'package:farm_flow_sales/Model/cartModel/cartModel.dart';
import 'package:farm_flow_sales/Model/inventoriesModel/inventories_model.dart';
import 'package:get/get.dart';

class InventoriesController extends GetxController {
  RxBool isApiCalling = false.obs;
  RxInt cartSubTotalValue = 0.obs;
  InventoriesDataModel inventoriesDataModel = InventoriesDataModel();
  ViewCartModel viewCartModel = ViewCartModel();
  RxBool isLoading = false.obs;
}
