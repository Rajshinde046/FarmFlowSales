class ApiUrls {
  // Base URL for the FarmFlow API.
  static const base = "https://staging.farmflowsolutions.com/api/";

  // Base URL for image resources.
  static const baseImageUrl = "https://staging.farmflowsolutions.com/public";

  //Weather API base URL.
  static const weatherApi = "http://api.weatherapi.com/v1/current.json";

  //Dashboard API
  static const dashboardApi = "${base}sales/dashboard";

  //Profile API
  static const profileInfoAPI = "${base}sales/profile-info";
  static const updateProfileInfoAPI = "${base}sales/profile-update";
  static const deleteProfileApi = "${base}sales/profile-delete";
  static const deleteProfileImageAPI = "${base}delete_profile/image";

  //Warehouses API
  static const warehouseApi = "${base}warehouse/list";

  //Inventory API
  static const inventoriesApi = "${base}inventory";
  static const inventoryDetailsApi = "${base}inventory/detail/";
  static const inventoryLivestockApi = "${base}inventory/livestocks";

  //Farmer API
  static const farmerlistApi = "${base}farmers/list";
  static const farmerdetailApi = "${base}farmer/";
  static const connectCodeApi = "${base}connect/farmer";
  static const farmerAddressApi = "${base}farmer/address";
  static const salesApi = "${base}sales";

  //Auth API
  static const loginApi = "${base}login";
  static const resendOtpApi = "${base}resend-otp";

  //Notification API
  static const notificationSettingApi = "${base}sales/notification-settings";
  static const notificationStatusApi = "${base}sales/notifications-status";
  static const notificationCountsApi = "${base}sales/notifications-count";
  static const getNotificationData = "${base}sales/notifications";

  //Pin API
  static const changePinApi = "${base}change/pin";
  static const checkPinApi = "${base}check/pin";

  //Orders API
  static const placeOrderApi = "${base}order/place";
  static const orderDetailsApi = "${base}details/order/";
  static const ongoingOrderApi = "${base}ongoing/orders";
  static const pendingOrderApi = "${base}pending/orders";
  static const completedOrderApi = "${base}completed/orders/";
  static const cancelOrderApi = "${base}cancel/order/";

  //Cart API
  static const manageCartApi = "${base}manage/cart";
  static const viewCartApi = "${base}view/cart";
  static const frequencyApi = "${base}frequency/list";

  //Settings API
  static const feedbackApi = "${base}sales/feedback";
  static const faqApi = "${base}faq/";
  static const contactUsApi = "${base}contact_us";
  static const contactListApi = "${base}contact/list";
  static const lougoutApi = "${base}logout";
}
