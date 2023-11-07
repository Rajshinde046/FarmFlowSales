class ApiUrls {
  static const base = "https://farmflow.betadelivery.com/api/";
  static const baseImageUrl = "https://farmflow.betadelivery.com/public";
  static const dashboardApi = "${base}sales/dashboard";
  static const weatherApi = "http://api.weatherapi.com/v1/current.json";

  // static const loginApi = "https://farmflow.betadelivery.com/api/login";
  static const warehouseApi =
      "https://farmflow.betadelivery.com/api/warehouse/list";
  static const farmerlistApi =
      "https://farmflow.betadelivery.com/api/farmers/list";

  static const profileInfoAPI = "${base}sales/profile-info";
  static const updateProfileInfoAPI = "${base}sales/profile-update";
  static const loginApi = "${base}login";
  static const inventoriesApi = "${base}inventory";
  static const inventoryDetailsApi = "${base}inventory/detail/";
  static const manageCartApi = "${base}manage/cart";
  static const viewCartApi = "${base}view/cart";
  static const inventoryLivestockApi = "${base}inventory/livestocks";
  static const farmerAddressApi = "${base}farmer/address";
  static const frequencyApi = "${base}frequency/list";
  static const placeOrderApi = "${base}order/place";
}
