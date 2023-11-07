import 'package:farm_flow_sales/Model/farmerModel/farmer_address_model.dart';
import 'package:farm_flow_sales/models/farmerListModel.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  int selectedFarmerId = 0;
  int selectedFarmAddressId = 0;
  String farmerName = "";
  List<int> cartDataId = [];
  String deliveryInstructionText = "";
  int selectedFrequencyId = 0;
  String selectedStartDate = "";
  int discountTypeId = 0;
  double discountValue = 0;
  double netValue = 0;

  FarmerListModel farmerListModel = FarmerListModel();
  FarmerAddressModel farmerAddressModel = FarmerAddressModel();
}
