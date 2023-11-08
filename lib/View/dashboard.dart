import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/Utils/texts.dart';
import 'package:farm_flow_sales/controller/inventories_controller.dart';
import 'package:farm_flow_sales/view_models/dashboardApi/dashboard_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as ls;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../Model/dashboardModel/dashboard_model.dart';
import 'package:farm_flow_sales/common/limit_range.dart';

import '../controller/dashboard_controller.dart';
import '../view_models/weatherApi/weather_api.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  bool lowFeed = true;
  bool saved = false;

  final location = ls.Location();
  Stream<DateTime>? _clockStream;
  String? humidity = "0", wind = "00.0";
  int selectedCurrentFeed = 0;
  DashboardController dashboardController = Get.put(DashboardController());
  InventoriesController inventoriesController =
      Get.put(InventoriesController());
  bool isDaytimeNow(
      DateTime currentTime, DateTime sunriseTime, DateTime sunsetTime) {
    return currentTime.isAfter(sunriseTime) && currentTime.isBefore(sunsetTime);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dashboardController.isDashboardApiLoading.value = true;
      _clockStream = Stream<DateTime>.periodic(const Duration(seconds: 1), (_) {
        return DateTime.now();
      });
      await getCurrentAddress();

      await DashboardApi().getDashboardData().then((value) async {
        dashboardController.dashboardModel =
            DashboardModel.fromJson(value.data);
        dashboardController.isDashboardApiLoading.value = false;
      });
    });
    super.initState();
  }

  Future getCurrentAddress() async {
    final serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled && !await location.requestService()) {
      return;
    }

    final permissionGranted = await location.hasPermission();
    if (permissionGranted != ls.PermissionStatus.granted) {
      if (await location.requestPermission() != ls.PermissionStatus.granted) {
        dashboardController.permissionStatus.value = permissionGranted.name;
        return;
      } else if (await location.hasPermission() ==
          ls.PermissionStatus.granted) {
        final permissionGranted = await location.hasPermission();

        dashboardController.permissionStatus.value = permissionGranted.name;
      }
    }
    if (await location.hasPermission() == ls.PermissionStatus.granted) {
      final permissionGranted = await location.hasPermission();

      dashboardController.permissionStatus.value = permissionGranted.name;
    }

    // dashboardController.isLocationFetching.value = true;
    final locationData = await location.getLocation();

    await getCurrentWeatherData(
        locationData.latitude!, locationData.longitude!);

    // dashboardController.isLocationFetching.value = false;
  }

  @override
  Widget build(BuildContext context) {
    DateTime sunrise = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 6, 30); // Example: 6:30 AM
    DateTime sunset = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 19, 00); // Example: 6:30 PM

    // Get the current time
    DateTime currentTime = DateTime.now();
    bool isDaytime = isDaytimeNow(currentTime, sunrise, sunset);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: AppColors.transparent,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 80.h),
        child: FloatingActionButton(
            backgroundColor: AppColors.buttoncolour,
            onPressed: () {
              inventoriesController.fromWarehouse = false;
              Get.toNamed('/searchnmain');
              // Get.to(() => const SearchProductCategories());
            },
            //  _incrementCounter,
            tooltip: 'Search',
            child: SvgPicture.asset(
              "assets/images/floatingbutton.svg",
              width: 51.w,
              height: 51.h,
            )
            // Icon(
            //   Icons.add,
            //   color: AppColors.white,
            // ),
            ),
      ),
      // extendBody: true,
      body: SafeArea(
        child: Obx(
          () => dashboardController.isDashboardApiLoading.value
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 75,
                        ),
                        SizedBox(
                          width: Get.width,
                          height: 170,
                          child: Shimmer.fromColors(
                              baseColor: AppColors.pistaE3FFE9,
                              highlightColor: AppColors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.h),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    )
                                  ],
                                  color: AppColors.pistaE3FFE9,
                                ),
                              )),
                        ),
                        sizedBoxHeight(15.h),
                        SizedBox(
                          width: Get.width,
                          height: 80,
                          child: Shimmer.fromColors(
                              baseColor: AppColors.redFA5658.withOpacity(0.2),
                              highlightColor: AppColors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.h),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    )
                                  ],
                                  color: AppColors.white,
                                ),
                              )),
                        ),
                        sizedBoxHeight(15.h),
                        SizedBox(
                          width: Get.width,
                          height: 300,
                          child: Shimmer.fromColors(
                              baseColor: AppColors.pistaE3FFE9,
                              highlightColor: AppColors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.h),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    )
                                  ],
                                  color: AppColors.pistaE3FFE9,
                                ),
                              )),
                        ),
                        sizedBoxHeight(15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            3,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: 105,
                              height: 100,
                              child: Shimmer.fromColors(
                                  baseColor: AppColors.pistaE3FFE9,
                                  highlightColor: AppColors.white,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.h),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.04),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        )
                                      ],
                                      color: AppColors.pistaE3FFE9,
                                    ),
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(75.w, 10.h, 16.w, 10.h),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textBlack20W7000Mon("Dashboard"),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            height: 42.h,
                            width: 42.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.h),
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 5.h,
                                  spreadRadius: 2.h,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed("/notification");
                                  },
                                  child: SvgPicture.asset(
                                    "assets/images/notification_bell.svg",
                                    height: 28.h,
                                    width: 28.h,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          sizedBoxWidth(10.w),
                          Container(
                            height: 42.h,
                            width: 42.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.h),
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 5.h,
                                  spreadRadius: 2.h,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed("/settings");
                                  },
                                  child: SvgPicture.asset(
                                    "assets/images/Settings.svg",
                                    height: 28.h,
                                    width: 28.h,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(27.h),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    )
                                  ],
                                  color: AppColors.pistaE3FFE9,
                                ),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        dashboardController.permissionStatus.value ==
                                                "denied"
                                            ? const SizedBox()
                                            : Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: (dashboardController
                                                                .weatherCondition
                                                                .value ==
                                                            "Sunny" ||
                                                        dashboardController
                                                                .weatherCondition
                                                                .value ==
                                                            "Clear")
                                                    ? isDaytime
                                                        ? Lottie.asset(
                                                            "assets/lotties/sun_animation.json",
                                                            height: 200.h,
                                                            width: 200.w,
                                                          )
                                                        : Lottie.asset(
                                                            "assets/lotties/moon_animation.json",
                                                            height: 175.h,
                                                            width: 175.w,
                                                          )
                                                    : (dashboardController
                                                                .weatherCondition
                                                                .value ==
                                                            "Partly cloudy")
                                                        ? isDaytime
                                                            ? Lottie.asset(
                                                                "assets/lotties/sun_with_cloud_animation.json",
                                                                height: 200.h,
                                                                width: 200.w,
                                                              )
                                                            : Lottie.asset(
                                                                "assets/lotties/moon_with_cloud_animation.json",
                                                                height: 200.h,
                                                                width: 200.w,
                                                              )
                                                        : (dashboardController
                                                                        .weatherCondition
                                                                        .value ==
                                                                    "Cloudy" ||
                                                                dashboardController
                                                                        .weatherCondition
                                                                        .value ==
                                                                    "Overcast")
                                                            ? Lottie.asset(
                                                                "assets/lotties/clouds.json",
                                                                height: 200.h,
                                                                width: 200.w,
                                                              )
                                                            : (dashboardController.weatherCondition.value == "Mist" ||
                                                                    dashboardController.weatherCondition.value ==
                                                                        "Fog" ||
                                                                    dashboardController.weatherCondition.value ==
                                                                        "Freezing fog")
                                                                ? Lottie.asset(
                                                                    "assets/lotties/cloud2.json",
                                                                    height:
                                                                        200.h,
                                                                    width:
                                                                        200.w,
                                                                  )
                                                                : (dashboardController.weatherCondition.value == "Patchy rain possible" ||
                                                                        dashboardController.weatherCondition.value == "Patchy freezing drizzle possible" ||
                                                                        dashboardController.weatherCondition.value == "Thundery outbreaks possible" ||
                                                                        dashboardController.weatherCondition.value == "Patchy light drizzle" ||
                                                                        dashboardController.weatherCondition.value == "Light drizzle" ||
                                                                        dashboardController.weatherCondition.value == "Freezing drizzle" ||
                                                                        dashboardController.weatherCondition.value == "Heavy freezing drizzle " ||
                                                                        dashboardController.weatherCondition.value == "Patchy light rain" ||
                                                                        dashboardController.weatherCondition.value == "Light rain" ||
                                                                        dashboardController.weatherCondition.value == "Moderate rain at times" ||
                                                                        dashboardController.weatherCondition.value == "Moderate rain" ||
                                                                        dashboardController.weatherCondition.value == "Heavy rain at times" ||
                                                                        dashboardController.weatherCondition.value == "Heavy rain" ||
                                                                        dashboardController.weatherCondition.value == "Light freezing rain" ||
                                                                        dashboardController.weatherCondition.value == "Moderate or heavy freezing rain" ||
                                                                        dashboardController.weatherCondition.value == "Torrential rain shower" ||
                                                                        dashboardController.weatherCondition.value == "Light sleet showers" ||
                                                                        dashboardController.weatherCondition.value == "Patchy light rain with thunder" ||
                                                                        dashboardController.weatherCondition.value == "Moderate or heavy rain with thunder")
                                                                    ? Lottie.asset(
                                                                        "assets/lotties/cloud_with_rain_animation.json",
                                                                        height:
                                                                            200.h,
                                                                        width:
                                                                            200.w,
                                                                      )
                                                                    : (dashboardController.weatherCondition.value == "Patchy snow possible" || dashboardController.weatherCondition.value == "Patchy sleet possible" || dashboardController.weatherCondition.value == "Light sleet" || dashboardController.weatherCondition.value == "Moderate or heavy sleet" || dashboardController.weatherCondition.value == "Patchy light snow" || dashboardController.weatherCondition.value == "Light snow" || dashboardController.weatherCondition.value == "Patchy moderate snow" || dashboardController.weatherCondition.value == "Moderate snow" || dashboardController.weatherCondition.value == "Patchy heavy snow" || dashboardController.weatherCondition.value == "Heavy snow" || dashboardController.weatherCondition.value == "Ice pellets" || dashboardController.weatherCondition.value == "Moderate or heavy sleet showers" || dashboardController.weatherCondition.value == "Light snow showers" || dashboardController.weatherCondition.value == "Moderate or heavy snow showers" || dashboardController.weatherCondition.value == "Light showers of ice pellets" || dashboardController.weatherCondition.value == "Moderate or heavy showers of ice pellets")
                                                                        ? Lottie.asset(
                                                                            "assets/lotties/snow_animation.json",
                                                                            height:
                                                                                200.h,
                                                                            width:
                                                                                200.w,
                                                                          )
                                                                        : (dashboardController.weatherCondition.value == "Blowing snow" || dashboardController.weatherCondition.value == "Blizzard" || dashboardController.weatherCondition.value == "Patchy light snow with thunder" || dashboardController.weatherCondition.value == "Moderate or heavy snow with thunder")
                                                                            ? Lottie.asset(
                                                                                "assets/lotties/snow_animation.json",
                                                                                height: 200.h,
                                                                                width: 200.w,
                                                                              )
                                                                            : Lottie.asset(
                                                                                "assets/lotties/cloud2.json",
                                                                                height: 200.h,
                                                                                width: 200.w,
                                                                              )),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20.w, 15.h, 36.w, 20.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                Get.width / 1.3,
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .contain,
                                                              child: textBlack20W7000Mon(
                                                                  "Welcome Back ${dashboardController.dashboardModel.data!.name}"),
                                                            ),
                                                          ),
                                                          sizedBoxHeight(15.h),
                                                          dashboardController
                                                                      .permissionStatus
                                                                      .value ==
                                                                  "denied"
                                                              ? Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "Enable Location to view \nweather details",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18.sp,
                                                                        color: AppColors
                                                                            .buttoncolour,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    sizedBoxHeight(
                                                                        15.h),
                                                                    InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        await getCurrentAddress();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            45.h,
                                                                        width:
                                                                            200,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20.h),
                                                                            color: AppColors.buttoncolour),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "Enable Location",
                                                                            style:
                                                                                TextStyle(color: AppColors.white, fontSize: 15.sp),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    sizedBoxHeight(
                                                                        15.h),
                                                                  ],
                                                                )
                                                              : const SizedBox(),
                                                          dashboardController
                                                                      .permissionStatus
                                                                      .value ==
                                                                  "denied"
                                                              ? const SizedBox()
                                                              : Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SvgPicture
                                                                        .asset(
                                                                      "assets/images/locationconnect.svg",
                                                                      color: AppColors
                                                                          .black,
                                                                      height:
                                                                          20.h,
                                                                      width:
                                                                          20.h,
                                                                    ),
                                                                    sizedBoxWidth(
                                                                        5.w),
                                                                    textBlack18W5000(
                                                                        dashboardController
                                                                            .locationText
                                                                            .value)
                                                                  ],
                                                                ),
                                                          dashboardController
                                                                      .permissionStatus
                                                                      .value ==
                                                                  "denied"
                                                              ? const SizedBox()
                                                              : textGreen50Bold(
                                                                  "${dashboardController.tempValue.value}° C"),
                                                          dashboardController
                                                                      .permissionStatus
                                                                      .value ==
                                                                  "denied"
                                                              ? const SizedBox()
                                                              : Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    rowWithText(
                                                                        "assets/images/humidity.png",
                                                                        humidity!,
                                                                        dashboardController
                                                                            .humidityValue
                                                                            .value),
                                                                    rowWithText(
                                                                        "assets/images/wind.png",
                                                                        "${wind!} kph",
                                                                        "${dashboardController.windValue.value} kph"),
                                                                  ],
                                                                ),
                                                          StreamBuilder<
                                                              DateTime>(
                                                            stream:
                                                                _clockStream,
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                  .hasData) {
                                                                String
                                                                    formattedDateTime =
                                                                    DateFormat(
                                                                            'E, d MMM - hh:mm a')
                                                                        .format(
                                                                            snapshot.data!);

                                                                return Center(
                                                                  child:
                                                                      textBlack18W5000(
                                                                    formattedDateTime,
                                                                  ),
                                                                );
                                                              } else {
                                                                return textBlack18W5000(
                                                                    'Loading...');
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              sizedBoxHeight(15.h),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed("/notification");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.h),
                                        color: AppColors.redFCDADA,
                                        // border: Border.all(
                                        //     color: AppColors.redFA5658, width: 1.h),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.04),
                                            blurRadius: 10,
                                            spreadRadius: 2,
                                          )
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w, vertical: 10.h),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 13.h,
                                                  backgroundColor: AppColors
                                                      .redFA5658
                                                      .withOpacity(0.2),
                                                  child: Icon(
                                                    Icons.warning_amber_rounded,
                                                    size: 16.h,
                                                    color: AppColors.redFA5658,
                                                  ),
                                                ),
                                                sizedBoxWidth(10.w),
                                                textblack14M("Loreum Ipsum Is"),
                                                const Spacer(),
                                                textGreen14("New")
                                              ],
                                            ),
                                            sizedBoxHeight(5.h),
                                            textGrey12L(
                                                "Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry Lorem")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  sizedBoxHeight(15.h),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(27.h),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    )
                                  ],
                                  color: AppColors.pistaE3FFE9,
                                ),
                                child: Column(
                                  children: [
                                    sizedBoxHeight(10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/images/locationRoad.png",
                                              height: 80.h,
                                              width: 80.h,
                                            ),
                                            // SvgPicture.asset(
                                            //   'assets/images/locationRoad.svg',
                                            //   height: 80.h,
                                            //   width: 80.h,
                                            // ),

                                            sizedBoxHeight(10.h),

                                            textBlack20W7000("Deliveries"),
                                          ],
                                        ),
                                        Lottie.asset(
                                            "assets/lotties/delivery_track.json",
                                            height: 150.h,
                                            width: 160.w),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 7.w, vertical: 16.h),
                                      child: Row(
                                        children: [
                                          deliveriesCard(
                                              "assets/images/timer.png",
                                              "In Progress Deliveries",
                                              dashboardController.dashboardModel
                                                  .data!.inprogress
                                                  .toString(),
                                              0),
                                          sizedBoxWidth(3.w),
                                          deliveriesCard(
                                              "assets/images/clock.png",
                                              "Pending Deliveries",
                                              dashboardController
                                                  .dashboardModel.data!.pending
                                                  .toString(),
                                              1),
                                          sizedBoxWidth(3.w),
                                          deliveriesCard(
                                              "assets/images/calender.png",
                                              "Completed Deliveries",
                                              dashboardController
                                                  .dashboardModel.data!.complete
                                                  .toString(),
                                              2),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              sizedBoxHeight(20.h),
                              Row(
                                children: [
                                  sfwCard("assets/images/sales.png", "Sales",
                                      "/sales"),
                                  sizedBoxWidth(15.w),
                                  sfwCard("assets/images/farmer.png", "Farmers",
                                      "/farmer"),
                                  sizedBoxWidth(15.w),
                                  sfwCard("assets/images/warehouse.png",
                                      "Warehouse", "/warehouse"),
                                ],
                              ),
                              sizedBoxHeight(10.h)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Widget rowWithText(String icon, text1, text2) {
    return Row(
      children: [
        Image.asset(
          icon,
          height: 25.h,
          width: 25.h,
          color: Colors.black,
        ),
        sizedBoxWidth(5.w),
        textBlack18W5000(
            dashboardController.isLocationFetching.value ? text1 : text2),
      ],
    );
  }

  getCurrentWeatherData(
    double lat,
    double lng,
  ) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        lat,
        lng,
      );

      final locality = placemarks.isNotEmpty ? placemarks[0].locality : '';
      dashboardController.locationText.value = locality!;

      final weatherData = await WeatherApi().getWeatherData(
        lat,
        lng,
      );

      dashboardController.tempValue.value =
          weatherData.data["current"]["temp_c"].toString();
      dashboardController.humidityValue.value =
          weatherData.data["current"]["humidity"].toString();
      dashboardController.windValue.value =
          weatherData.data["current"]["wind_kph"].toString();
      dashboardController.weatherCondition.value =
          weatherData.data["current"]["condition"]['text'].toString();

      setState(() {});
    } catch (e) {
      utils.showToast("Error fetching location or weather data");
    }
  }

  Widget bottomContainer(String txt, String number) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 26.w,
      height: 128.h,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff0E5F02), width: 0.2.h),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
        color: AppColors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(8.h),
                height: 41.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: const Color(0xffB1E8A9),
                ),
                width: 45.w,
                child: Center(
                  child: SvgPicture.asset('assets/images/Settings.svg'),
                ),
              ),
              Flexible(child: textBlack16(txt))
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sizedBoxWidth(5.w),
              textGreen50R(number),
              const Spacer(),
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: const Color(0xffB1E8A9).withOpacity(0.32),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget deliveriesCard(String image, String title, String number, int index) {
    return Expanded(
      child: Container(
        height: 155.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(index == 0 ? 10.h : 0),
              bottomLeft: Radius.circular(index == 0 ? 10.h : 0),
              topRight: Radius.circular(index == 2 ? 10.h : 0),
              bottomRight: Radius.circular(index == 2 ? 10.h : 0)),
          color: AppColors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 5.w),
          child: Column(
            children: [
              Image.asset(
                image,
                // "assets/images/timer.png",
                height: 30.h,
                width: 18.w,
              ),

              sizedBoxHeight(10.h),

              textblack14M(title
                  // "In Progress Delivery"
                  ),

              // sizedBoxHeight(10.h),
              const Spacer(),

              textGreen20W7000Mon(number)
            ],
          ),
        ),
      ),
    );
  }

  Widget sfwCard(String image, String title, String onTapnamed) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Get.toNamed(onTapnamed);
        },
        child: Container(
          height: 110.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.h),
            color: AppColors.pistaE3FFE9,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 5.h,
                spreadRadius: 0.5.h,
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 5.w),
            child: Column(
              children: [
                Image.asset(
                  image,
                  // "assets/images/timer.png",
                  height: 46.h,
                  width: 46.h,
                ),

                sizedBoxHeight(10.h),

                textblack14M(title
                    // "In Progress Delivery"
                    ),

                // sizedBoxHeight(10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
