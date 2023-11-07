import 'package:get/get.dart';

import '../Model/dashboardModel/dashboard_model.dart';

//import '../models/dashboardModel.dart';

class DashboardController extends GetxController {
  RxString permissionStatus = "".obs;
  RxString tempValue = "00.0".obs;
  RxString humidityValue = "0".obs;
  RxString windValue = "00.0".obs;
  RxString locationText = "Unknown".obs;
  RxBool isLocationFetching = false.obs;
  RxString weatherCondition = "".obs;
  RxBool isDashboardApiLoading = true.obs;
  DashboardModel dashboardModel = DashboardModel();
}
