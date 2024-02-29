import 'package:get/get.dart';

import '../Model/dashboardModel/dashboard_model.dart';
import '../Model/weather_model.dart';

//import '../models/dashboardModel.dart';

class DashboardController extends GetxController {
  RxString notificationCount = "0".obs;
  RxString permissionStatus = "".obs;
  RxString tempValue = "00.0".obs;
  RxString humidityValue = "0".obs;
  RxString userName = "".obs;

  RxInt selectedTab = 0.obs;
  RxInt selectedIndex = 2.obs;
  RxString windValue = "00.0".obs;
  RxString locationText = "Unknown".obs;
  RxBool isLocationFetching = false.obs;
  RxString weatherCondition = "".obs;
  RxBool isDashboardApiLoading = true.obs;
  bool isDashboardFirst = true;
  DashboardModel dashboardModel = DashboardModel();
  RxBool isWeatherForecastLoading = false.obs;
  double? currentLat = 0, currentLng = 0;
  List<WeatherModel> weatherModel = [];
}
